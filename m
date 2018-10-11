From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 11 Oct 2018 18:40:22 +0200 (CEST)
Subject: [Cocci] Searching for parameter usages of pte_alloc()
In-Reply-To: <20181011162840.GA199386@joelaf.mtv.corp.google.com>
References: <20181010211125.GA128537@joelaf.mtv.corp.google.com>
 <93da55ff-c807-6587-7ef3-3d2af820117d@users.sourceforge.net>
 <20181011154346.GA186033@joelaf.mtv.corp.google.com>
 <alpine.DEB.2.20.1810111746210.3392@hadrien>
 <20181011162840.GA199386@joelaf.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1810111833410.3392@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> Sure, so if I have code like this:
> #define pte_alloc_one(mm, vmaddr) ((pte_t *) page_table_alloc(mm))
>
> I want to have a rule that does:
> - #define pte_alloc_one(mm, vmaddr) ((pte_t *) page_table_alloc(mm))
> + #define pte_alloc_one(mm) ((pte_t *) page_table_alloc(mm))
>
> So far everything I tried only works for functions so I was wondering how one
> do this with macros.

Maybe

@r@
position p;
identifier i,a,b;
@@

#define i(a,b)@p <+...b...+>

@@
position p != r.p;
identifier i,a,b;
expresssion e;
@@

- #define i(a,b)@p e
+ #define i(a) e

The rule r finds #defines that refer to the second argument, and records
their position in p, while the second rule finds all other #defines with
two arguments.

Of course, you would want to use a regular expression for the macro name,
or do something to avoid changing all two argument macros.

Macros are often defined in header files, so you may want to use the
command line options --no-includes --include-headers.  --no-includes means
ignore header files when they are included into .c files and
--include-headers means treat both .c an .h files.  Otherwise, you only get
.c files.

julia
