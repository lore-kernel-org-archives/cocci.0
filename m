From: julia.lawall@lip6.fr (Julia Lawall)
Date: Mon, 25 Jun 2018 19:13:11 +0200 (CEST)
Subject: [Cocci] Support for C++ delete expressions
In-Reply-To: <6f9689bc-4fd8-34ff-ed26-f8a57ad16baf@users.sourceforge.net>
References: <169e2663-6c92-c6ce-4b27-47d8494490f4@users.sourceforge.net>
 <alpine.DEB.2.20.1806031831320.2242@hadrien>
 <7e3bd4a1-daaf-5b84-5de2-c446cc0a4c1c@users.sourceforge.net>
 <alpine.DEB.2.20.1806032126430.2740@hadrien>
 <c8f05f51-fa3c-9770-ac99-20a23df8e4c3@users.sourceforge.net>
 <alpine.DEB.2.20.1806111248510.3334@hadrien>
 <6f9689bc-4fd8-34ff-ed26-f8a57ad16baf@users.sourceforge.net>
Message-ID: <alpine.DEB.2.20.1806251912300.4673@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Mon, 25 Jun 2018, SF Markus Elfring wrote:

> > delete [] is now supported by the C++ parser (ie with option --c++).
>
> This is nice.
>
>
> > Note that no C++ specific operators are supported by the semantic
> > patch language.
>
> How will the software situation evolve further for corresponding key words?
>
> Would you ever like to support a source code transformation
> where unnecessary null pointer checks can be removed before
> such delete statements?
>
> Another description:
> https://clang.llvm.org/extra/clang-tidy/checks/readability-delete-null-pointer.html

C++ is not a priority for me personally.  If someone wants to fund adding
better support for C++, that would probably be good for Coccinelle.

julia

>
> Regards,
> Markus
>
