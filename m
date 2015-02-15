From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sun, 15 Feb 2015 06:54:14 +0100 (CET)
Subject: [Cocci] remove typedefs from struct
In-Reply-To: <db4839c19266450b88ea802a7c5ab597@BL2FFO11FD013.protection.gbl>
References: <2bb2afa2a75f464b900af8506ddc84dd@BN1BFFO11FD029.protection.gbl>
 <alpine.DEB.2.10.1502141955040.6185@hadrien>
 <db4839c19266450b88ea802a7c5ab597@BL2FFO11FD013.protection.gbl>
Message-ID: <alpine.DEB.2.02.1502150652350.2033@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> When I run with --parse-c, all I get is this:
>   init_defs_builtins: /usr/share/coccinelle/standard.h
>   
>   PARSING: testcase.c
>   -----------------------------------------------------------------------
>   maybe 10 most problematic tokens
>   -----------------------------------------------------------------------
>   -----------------------------------------------------------------------
>   NB total files = 1; perfect = 1; pbs = 0; timeout = 0; =========> 100%
>   nb good = 10,  nb passed = 0 =========> 0.000000% passed
>   nb good = 10,  nb bad = 0 =========> 100.000000% good

OK, so there is no problem in this direction.

> It doesn't show any code (not sure whether that is correct or not), but 
> no 'BAD' either. Running that file through gcc -c -Wall works fine as 
> well. So, it should be legal c (just a warning regarding an unused 
> variable).

gcc -c is not a very useful test because gcc expands macros and Coccinelle 
does not.  So Coccinelle might not be able to parse something that gcc 
can.

> I attached the testcase.c and my cocci patch. This is the diff I get:

Thanks, I will take a look.

julia

>   init_defs_builtins: /usr/share/coccinelle/standard.h
>   HANDLING: testcase.c
>   diff =
>   --- testcase.c
>   +++ /tmp/cocci-output-17008-c37c42-testcase.c
>   @@ -1,11 +1,11 @@
>   -typedef struct a_struct {
>   +struct a_struct {
>           int a_member;
>   -} a_struct;
>   +};
>   
>    static const a_struct *const a_struct_array[3] = {
>    };
>   
>    unsigned int function(const a_struct* const a_struct_arg);
>   
>   -static a_struct a_struct_instance;
>   +static struct a_struct a_struct_instance;
>    static const a_struct a_const_struct_instance;
> 
> 	Thanks,
> 	Soren
> 
