From: yangyibiao@nju.edu.cn (=?utf-8?B?5p2o5bey5b2q?=)
Date: Fri, 13 Oct 2017 21:43:17 +0800
Subject: [Cocci] How to remove unused global variables by using Coccinelle?
Message-ID: <tencent_0C53782B45D6A684021E71E3@qq.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hello,

Thanks for this awesome tool - Coccinelle. 

Currently, I am trying to use Coccinelle to remove unused global variables in C source code. While applying the following remove.cocci to test.c , it does not work.

Can anyone help?

Thanks.
---
Yibiao

$ spatch --version
spatch version 1.0.6 compiled with OCaml version 4.02.3
Flags passed to the configure script: [none]
Python scripting support: yes
Syntax of regular expresssions: PCRE

$ spatch ?in-place -sp-file remove.cocci small.c
init_defs_builtins: /usr/local/lib/coccinelle/standard.h
HANDLING: small.c

$ cat remove.cocci
@@
type T;
identifier i;
expression E;
@@
- static T i = E;
  ... when != I

$ cat small.c
static int g = 0;
int main()
{
    return 0;
}
