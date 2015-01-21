From: eliseomarmol@gmail.com (=?utf-8?Q?Eliseo_Mart=C3=ADnez?=)
Date: Wed, 21 Jan 2015 15:05:07 +0100
Subject: [Cocci] Matching functions with attributes
Message-ID: <D59A6A6F-9D60-44DE-9B6C-8B615B776EA8@gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi, 

>From what I?ve read, I understand attributes are not supported by coccinelle.
But I?m still wondering it there would be a way to perform a task I?d like to do: Checking whether functions marked as returning non-null are used in any place so that return value is checked for nullness/nonnullness.
So, this breaks into 2 subproblems:

1) Matching desired functions.

I know I can?t directly match functions having certain attributes.
But we don?t use attributes directly. We use some macros for that.
So, all functions I?d like to pick include the macro FUNC_ATTR_NONNULL_RET in their declaration/definition.
Then, would there be any way to match functions having the literal ?FUNC_ATTR_NONNULL_RET? in their declaration/definition?

2) Applying some rules for the same set of functions.

Up until now, I?ve done this by manually obtaining the list of desired functions, and then running this spatch:

```
@@ identifier func =~ "^(transstr|list_alloc|listitem_alloc|dict_alloc|dictitem_alloc|dictitem_copy|vim_strsave_fnameescape|ga_concat_strings|enc_canonize|reverse_text|get_tv_string|get_tv_string_buf|viminfo_readstring|ga_concat_strings_sep|xmalloc|xcalloc|xrealloc|xmallocz|xmemdupz|xstrchrnul|xmemscan|xstpcpy|xstpncpy|xstrdup|xstrndup|xmemdup|msg_show_console_dialog|home_replace_save|get_register|invocation_path_tail|concat_fnames|save_absolute_path|getroom|vim_strsave|vim_strnsave|vim_strsave_escaped|vim_strsave_escaped_ext|vim_strsave_shellescape|vim_strsave_up|vim_strnsave_up|strup_save|concat_str)$"; statement S; @@

(
* if (func(...) == NULL) S;
|
* if (func(...) != NULL) S;
)

@@ identifier func =~ "^(transstr|list_alloc|listitem_alloc|dict_alloc|dictitem_alloc|dictitem_copy|vim_strsave_fnameescape|ga_concat_strings|enc_canonize|reverse_text|get_tv_string|get_tv_string_buf|viminfo_readstring|ga_concat_strings_sep|xmalloc|xcalloc|xrealloc|xmallocz|xmemdupz|xstrchrnul|xmemscan|xstpcpy|xstpncpy|xstrdup|xstrndup|xmemdup|msg_show_console_dialog|home_replace_save|get_register|invocation_path_tail|concat_fnames|save_absolute_path|getroom|vim_strsave|vim_strnsave|vim_strsave_escaped|vim_strsave_escaped_ext|vim_strsave_shellescape|vim_strsave_up|vim_strnsave_up|strup_save|concat_str)$"; identifier var; statement S; expression E; @@

  var = func(...);
  ... when != var = E
(
* if (var == NULL) S;
|
* if (var != NULL) S;
)
```

As you see, I have to replicate the list. Is there any better way to achieve the same effect?

Thanks in advance.
Eliseo.
