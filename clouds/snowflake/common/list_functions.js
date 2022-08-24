#!/usr/bin/env node

// List the functions based on the input filters

// ./list_functions.js --diff=quadbin/test/QUADBIN_TOZXY.test.js
// ./list_functions.js --functions=ST_TILEENVELOPE
// ./list_functions.js --modules=quadbin

const fs = require('fs');
const path = require('path');
const argv = require('minimist')(process.argv.slice(2));

const inputDir = '.';
const diff = argv.diff || [];
const modulesFilter = (argv.modules && argv.modules.split(',')) || [];
const functionsFilter = (argv.functions && argv.functions.split(',')) || [];
const all = !(diff.length || modulesFilter.length || functionsFilter.length);

// Extract functions
const functions = [];
const modules = fs.readdirSync(inputDir);
modules.forEach(module => {
    const testdir = path.join(inputDir, module, 'test');
    if (fs.existsSync(testdir)) {
        const files = fs.readdirSync(testdir);
        files.forEach(file => {
            pfile = path.parse(file);
            if (file.endsWith('.test.js')) {
                const name = pfile.name.replace('.test', '');
                functions.push({
                    name,
                    module,
                    fullPath: path.join(testdir, file)
                });
            }
        });
    }
});

// Filter functions
const output = [];
function filter (f) {
    const include = all || diff.includes(path.join(f.fullPath)) || functionsFilter.includes(f.name) || modulesFilter.includes(f.module);
    if (include) {
        output.push(f.fullPath);
    }
}
functions.forEach(f => filter(f));

process.stdout.write(output.join(' '));