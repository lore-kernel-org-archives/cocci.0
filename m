From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 4 Aug 2015 10:31:37 +0200 (CEST)
Subject: [Cocci] Replacing function definition with a macro
In-Reply-To: <CANMuvJ=qX99uQAL4PL1jt8ExqthVq_BJO6q+GNoqzLSrHCxqqw@mail.gmail.com>
References: <CANMuvJ=qX99uQAL4PL1jt8ExqthVq_BJO6q+GNoqzLSrHCxqqw@mail.gmail.com>
Message-ID: <alpine.DEB.2.10.1508041029360.2327@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Tue, 4 Aug 2015, Petr Mal?t wrote:

> Hi All,
> I'm trying to replace a function prototype in the definition with a
> macro. The reason is to generate stubs to do some argument mangling.
> The following is my cocci file:
>
> @@
> type T1;
> identifier i1, name;
> @@
> - long name(T1 i1) {
> + COMPAT_SYSCALL_DEFINE1(name, T1, i1) {
>   ...
>   }
>
> And the following is my testing code:
>
> #define __SC_DECL1(t1, a1) t1 a1
> #define COMPAT_SYSCALL_DEFINE1(name, ...) \
>                 long compat_sys_##name(__SC_DECL1(__VA_ARGS__))
> long test(int first) {
>         return 0;
> }
>
>
> And I expect spatch to replace
>   long test(int first) {
> with
>   COMPAT_SYSCALL_DEFINE1(test, int, first) {
> but when I try to run it, I get
>   init_defs_builtins: /usr/local/lib/coccinelle/standard.h
>   82 86
>   Fatal error: exception Failure("plus: parse error:
>    = File "test.cocci", line 6, column 25,  charpos = 82
>       around = 'name', whole content = + COMPAT_SYSCALL_DEFINE1(name, T1, i1) {
>   ")
> Any idea what am I doing wrong?

Coccinelle expects that each element in a parameter list will have the
form type identifier.  In the case of name, you just have an identifier.
I don't really see a solution.

julia
