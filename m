From: julia.lawall@lip6.fr (Julia Lawall)
Date: Mon, 22 Dec 2014 07:15:55 +0100 (CET)
Subject: [Cocci] Coccinelle and token concatenation (##) preprocessor
 macros
In-Reply-To: <CAGOGP4TFHStn_rou7KHPDVJ8yPZYPa9mounYAmbbENKVTqqQ7A@mail.gmail.com>
References: <CAGOGP4TFHStn_rou7KHPDVJ8yPZYPa9mounYAmbbENKVTqqQ7A@mail.gmail.com>
Message-ID: <alpine.DEB.2.02.1412220710571.2033@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Sun, 21 Dec 2014, Jim Barlow wrote:

> Hello,
> I'm trying to get coccinelle working with libressl (an openssl fork). It
> seems to have trouble with the following (admitted atrocious) macro which
> directs the compiler to declare a struct with an arbitrary name.
> 
> Here's an example:
> 
> typedef struct stack_st {
> int num;
> char **data;
> int sorted;
> 
> int num_alloc;
> int (*comp)(const void *, const void *);
> } _STACK;
> 
> #define STACK_OF(type) struct stack_st_##type
> 
> #define DECLARE_STACK_OF(type) \
> STACK_OF(type) \
> ? ? { \
> ? ? _STACK stack; \
> ? ? };

It is this code, not the ## that it doesn't like.  It doesn't recognize 
STACK_OF(type) as a type.  Coccinelle (mostly) doesn't expand macros, even 
if they are immediately available.  The goal is that patterns should be 
written in terms of the code that one sees, and not the result of macro 
expansion.

What is the actual problem?  Is it that you want to transform C code that 
contains STACK_OF(xxx)?  If so, it could be reasonable to add

#define STACK_OF(x) struct x

to your standard.h file.  You can also make a separate file and provide it 
with the command-line argument --macro-file mymacros.h.

julia

> DECLARE_STACK_OF(anything)
> 
> 
> Normally the typedef and #defines would appear in a global header,
> DECLARE_STACK_OF in a local header, and STACK_OF in C source files,
> including function definitions. I placed all in one file for testing.
> 
> I am testing spatch running as:
>       spatch --parse-c cocci-test.c
> 
> Any suggestions to get this working, or are ## macros not supported at this
> time??
> 
> I'm using coccinelle 1.0.0-rc21 on OS X (Homebrew). I have tried manually
> building -rc23 but was unable to build, but that's a separate question.
> 
> Thanks.
> 
> --
> Jim Barlow,?P.Eng.
> 
> 
> 
