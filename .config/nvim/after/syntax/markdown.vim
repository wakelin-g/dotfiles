" " Vim syntax file
" " Language: Markdown
" " Maintainer: Griffen Wakelin
" " Latest revision: 18 July 2023
"
" syntax region markdownWikiLink matchgroup=markdownLinkDelimiter start="\[\[" end="\]\]" contains=markdownUrl keepend oneline concealends
" syntax region markdownLinkText matchgroup=markdownLinkTextDelimiter start="!\=\[\%(\%(\_[^][]\|\[\_[^][]*\]\)*]\%( \=[[(]\)\)\@=" end="\]\%( \=[[(]\)\@=" nextgroup=markdownLink,markdownId skipwhite contains=@markdownInline,markdownLineStart concealends
" syntax region markdownLink matchgroup=markdownLinkDelimiter start="(" end=")" contains=markdownUrl keepend contained conceal
