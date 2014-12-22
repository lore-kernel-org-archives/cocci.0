From: jim@purplerock.ca (Jim Barlow)
Date: Sun, 21 Dec 2014 17:21:19 -0800
Subject: [Cocci] Coccinelle and token concatenation (##) preprocessor macros
Message-ID: <CAGOGP4TFHStn_rou7KHPDVJ8yPZYPa9mounYAmbbENKVTqqQ7A@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hello,

I'm trying to get coccinelle working with libressl (an openssl fork). It
seems to have trouble with the following (admitted atrocious) macro which
directs the compiler to declare a struct with an arbitrary name.

Here's an example:


typedef struct stack_st {
int num;
char **data;
int sorted;

int num_alloc;
int (*comp)(const void *, const void *);
} _STACK;

#define STACK_OF(type) struct stack_st_##type

#define DECLARE_STACK_OF(type) \
STACK_OF(type) \
    { \
    _STACK stack; \
    };

DECLARE_STACK_OF(anything)


Normally the typedef and #defines would appear in a global header,
DECLARE_STACK_OF in a local header, and STACK_OF in C source files,
including function definitions. I placed all in one file for testing.

I am testing spatch running as:

spatch --parse-c cocci-test.c

Any suggestions to get this working, or are ## macros not supported at this
time?

I'm using coccinelle 1.0.0-rc21 on OS X (Homebrew). I have tried manually
building -rc23 but was unable to build, but that's a separate question.

Thanks.

-- 
*Jim Barlow, **P.Eng.*
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20141221/c680d1cb/attachment.html>
