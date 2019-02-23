/* tslint:disable no-var-requires */
import {command, help, parse, version} from 'commander';
import {join} from 'path';
import {CliCommandProvider} from '.';
import {findPluginsWithPrefix} from './utils';

version(require(join('..', 'package.json')).version).name('diez');

const registerWithProvider = (provider: CliCommandProvider) => {
  command(provider.command).description(provider.description).action(provider.action);
};

findPluginsWithPrefix('cli').then((plugins) => {
  for (const plugin of plugins) {
    try {
      const {provider} = require(plugin);
      registerWithProvider(provider);
    } catch (error) {
      // Noop.
    }
  }

  if (!process.argv.slice(2).length) {
    help();
  }

  parse(process.argv);
});