import neovim


@neovim.plugin
class Limit(object):
    def __init__(self, vim):
        self.vim = vim
        self.calls = 0

    @neovim.command('Cmd', range='', nargs='*', sync=True)
    def command_handler(self, args, ranger):
        self._increment_calls()

    @neovim.autocmd('BufEnter', pattern='*.py', eval='expand("<afile>")',
                    sync=True)
    def autocmd_handler(self, filename):
        self._increment_calls()

    @neovim.function('Func')
    def function_hander(self, args):
        self._increment_calls()

    def _increment_calls(self):
        if self.calls == 5:
            raise Exception('Too many calls!')
        self.calls += 1
