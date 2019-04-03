import commander from 'commander';
import {createPackage} from './commands/create-package';
import {generateDocs} from './commands/generate-docs';
import {currentVersion} from './internal/helpers';

commander.version(currentVersion);

commander
  .command('create-package [registry]')
  .description('Create a Diez package.')
  .action(createPackage);

commander
  .command('generate-docs')
  .description('Generate docs.')
  .action(generateDocs);

if (!process.argv.slice(2).length) {
  commander.outputHelp();
  process.exit();
}

commander.on('command:*', () => {
  commander.outputHelp();
  process.exit();
});

commander.parse(process.argv);
