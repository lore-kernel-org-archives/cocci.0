From: oss@malat.biz (=?UTF-8?Q?Petr_Mal=C3=A1t?=)
Date: Tue, 4 Aug 2015 13:05:03 +0200
Subject: [Cocci] Replacing function definition with a macro
In-Reply-To: <alpine.DEB.2.10.1508041029360.2327@hadrien>
References: <CANMuvJ=qX99uQAL4PL1jt8ExqthVq_BJO6q+GNoqzLSrHCxqqw@mail.gmail.com>
 <alpine.DEB.2.10.1508041029360.2327@hadrien>
Message-ID: <CANMuvJn0hJm1bQ1aRz+42QgVqvmAQKEgJZo7d8kFhLH5S3wWxQ@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi Julia,
thanks for the answer
> Coccinelle expects that each element in a parameter list will have the
> form type identifier.  In the case of name, you just have an identifier.
> I don't really see a solution.
I though similar operations are generally possible, if all required macros
are known. Anyway, I've worked it around by using something like

@@
type T1;
identifier i1, name;
typedef DELME;
@@
- long name(T1 i1) {
+ COMPAT_SYSCALL_DEFINE1(DELME name, T1 DELME_TOO, DELME i1) {
  ...
  }

and then fixing the generated patch with sed.

Cheers,
  Petr
