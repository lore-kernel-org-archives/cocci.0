From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sun, 3 Jun 2018 18:32:08 +0900 (JST)
Subject: [Cocci] Support for C++ delete expressions?
In-Reply-To: <169e2663-6c92-c6ce-4b27-47d8494490f4@users.sourceforge.net>
References: <169e2663-6c92-c6ce-4b27-47d8494490f4@users.sourceforge.net>
Message-ID: <alpine.DEB.2.20.1806031831320.2242@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Sun, 3 Jun 2018, SF Markus Elfring wrote:

> Hello,
>
> The information ?make a small attempt to parse C++ files? is provided for
> the parameter ?--c++? of the program ?spatch?.
> How does the software development situation look like for the handling
> of ?delete expressions??

Delete is handled.  If there is some example for which the result is not
satisfactory, you would have to provide it.

julia

> http://en.cppreference.com/w/cpp/language/delete
>
> Regards,
> Markus
> _______________________________________________
> Cocci mailing list
> Cocci at systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
