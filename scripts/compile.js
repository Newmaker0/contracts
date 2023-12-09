const hre = require("hardhat");
const fs = require('fs');
const path = require('path');
const rimraf = require('rimraf');

async function main() {
    // Compile all contracts
    await hre.run('compile');

    // The contracts are compiled and their artifacts are saved in the 'artifacts' directory1
    const contractsDir = path.join(__dirname, '../artifacts/contracts');
    
    // Create 'compiled' directory if it does not exist
    const compiledDir = './compiled';
    if (fs.existsSync(compiledDir)){
        rimraf.sync(compiledDir);
    }
    if (!fs.existsSync(compiledDir)){
        fs.mkdirSync(compiledDir);
    }

    fs.readdirSync(contractsDir).forEach(folder => {
        const contractDir = path.join(contractsDir, folder);
        fs.readdirSync(contractDir).forEach(file => {
            // Filter out non-JSON files and debug files
            if (path.extname(file) === '.json' && !file.endsWith('.dbg.json')) {
                const contractJson = require(path.join(contractDir, file));
                const output = {
                    abi: contractJson.abi,
                    bytecode: contractJson.bytecode
                };

                // Create a directory for each contract's artifacts, stripping out the '.sol' extension
                const contractName = folder.replace('.sol', '');
                const contractOutputDir = path.join(compiledDir, contractName);
                if (!fs.existsSync(contractOutputDir)) {
                    fs.mkdirSync(contractOutputDir, { recursive: true });
                }

                // Write ABI and bytecode to a separate JSON file within its directory
                fs.writeFileSync(path.join(contractOutputDir, `${path.basename(file)}`), JSON.stringify(output, null, 2));
            }
        });
    });
}

main().then(() => process.exit(0)).catch(error => {
    console.error(error);
    process.exit(1);
});
