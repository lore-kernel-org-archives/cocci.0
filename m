From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 4 Aug 2015 13:29:30 +0200 (CEST)
Subject: [Cocci] Replacing function definition with a macro
In-Reply-To: <CANMuvJn0hJm1bQ1aRz+42QgVqvmAQKEgJZo7d8kFhLH5S3wWxQ@mail.gmail.com>
References: <CANMuvJ=qX99uQAL4PL1jt8ExqthVq_BJO6q+GNoqzLSrHCxqqw@mail.gmail.com>
 <alpine.DEB.2.10.1508041029360.2327@hadrien>
 <CANMuvJn0hJm1bQ1aRz+42QgVqvmAQKEgJZo7d8kFhLH5S3wWxQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.10.1508041328070.2327@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Tue, 4 Aug 2015, Petr Mal?t wrote:

> Hi Julia,
> thanks for the answer
> > Coccinelle expects that each element in a parameter list will have the
> > form type identifier.  In the case of name, you just have an identifier.
> > I don't really see a solution.
> I though similar operations are generally possible, if all required macros
> are known.

No.  Macros are somewhat taken into account when parsing the C code.  But
here you are talking about the SmPL (pattern) code, which is different.

> Anyway, I've worked it around by using something like
>
> @@
> type T1;
> identifier i1, name;
> typedef DELME;
> @@
> - long name(T1 i1) {
> + COMPAT_SYSCALL_DEFINE1(DELME name, T1 DELME_TOO, DELME i1) {
>   ...
>   }
>
> and then fixing the generated patch with sed.

Yeah, not ideal, but perhaps easier than making all the changes by hand.

julia
