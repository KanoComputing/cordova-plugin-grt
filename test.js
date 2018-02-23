const fs = require('fs');
const { execSync } = require('child_process');
const os = require('os');
const mkdirp = require('mkdirp');
const del = require('del');

const TMP_DIR = os.tmpdir();
const PLUGIN_NAME = 'cordova-plugin-grt';
const NAME = `${PLUGIN_NAME}-tests`;
const APP_NAME = NAME.replace(/-/g, '');
const DIR = `${TMP_DIR}/${NAME}`;

const platform = 'android';
const platformVersion = '6';

const TEST_FRAMEWORK_URL = 'https://github.com/apache/cordova-plugin-test-framework';

function updateConfig() {
    const file = `${DIR}/config.xml`;
    const buffer = fs.readFileSync(file);
    const contents = buffer.toString();
    fs.writeFileSync(file, contents.replace('<content src="index.html" />', '<content src="cdvtests/index.html" />'));
}

function setup() {
    del.sync(DIR, { force: true });
    mkdirp.sync(DIR);
    execSync(`cordova create ${NAME} com.kano.${NAME.replace(/-/g, '')} ${APP_NAME}`, { cwd: TMP_DIR, stdio: [0, 1, 2] });
    execSync(`cordova platform add ${platform}@${platformVersion}`, { cwd: DIR, stdio: [0, 1, 2] });
    execSync(`cordova plugin add ${TEST_FRAMEWORK_URL}`, { cwd: DIR, stdio: [0, 1, 2] });
}

function run() {
    updateConfig();
    execSync(`cordova plugin rm ${PLUGIN_NAME}`, { cwd: DIR, stdio: [0, 1, 2] });
    execSync(`cordova plugin rm ${PLUGIN_NAME}-tests`, { cwd: DIR, stdio: [0, 1, 2] });
    execSync(`cordova plugin add ${__dirname}`, { cwd: DIR, stdio: [0, 1, 2] });
    execSync(`cordova plugin add ${__dirname}/tests`, { cwd: DIR, stdio: [0, 1, 2] });
    execSync(`cordova run ${platform}`, { cwd: DIR, stdio: [0, 1, 2] });
}

if (!fs.existsSync(DIR)) {
    setup();
}

run();
