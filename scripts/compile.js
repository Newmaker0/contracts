const hre = require("hardhat");
const fs = require('fs');
const path = require('path');
const rimraf = require('rimraf');

async function main() {
    // Compile all contracts
    await hre.run('compile');

    // The contracts are compiled and their artifacts are saved in the 'artifacts' directory
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
            // Filter out non-JSON files
            if (path.extname(file) === '.json' && !file.endsWith('.dbg.json')) {
                const contractJson = require(path.join(contractDir, file));
                const output = {
                    abi: contractJson.abi,
                    bytecode: contractJson.bytecode
                };

                // Write ABI and bytecode to a separate JSON file
                fs.writeFileSync(`./compiled/${folder}${file}`, JSON.stringify(output, null, 2));
            }
        });
    });
}

main().then(() => process.exit(0)).catch(error => {
    console.error(error);
    process.exit(1);
});
