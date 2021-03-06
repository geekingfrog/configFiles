let configRoot = fnamemodify(expand($MYVIMRC), ':p:h')

if &shell =~# 'fish$'
    set shell=bash
endif

" source configRoo/plugins.vimrc"
execute 'source' configRoot . '/plugins.vimrc'
execute 'source' configRoot . '/general.vimrc'
execute 'source' configRoot . '/theming.vimrc'
execute 'source' configRoot . '/codeEditting.vimrc'
execute 'source' configRoot . '/completion.vimrc'
execute 'source' configRoot . '/keys.vimrc'
