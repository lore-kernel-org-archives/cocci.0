From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sat, 17 Feb 2018 20:05:30 +0100 (CET)
Subject: [Cocci] Handling of variations in function call parameters
In-Reply-To: <81e498d6-294a-8542-9338-50ca8e96303c@users.sourceforge.net>
References: <96508c06-9473-e558-fba1-7e4db6646ee7@users.sourceforge.net>
 <alpine.DEB.2.20.1802171703560.2205@hadrien>
 <2b678153-b7c0-6100-6d9c-624bd61e2b78@users.sourceforge.net>
 <alpine.DEB.2.20.1802171741560.2205@hadrien>
 <a3c2fbd6-00f4-0113-aab8-4caeed631e1c@users.sourceforge.net>
 <alpine.DEB.2.20.1802171808110.2205@hadrien>
 <b65bd20c-de90-2136-b375-246b873cf2a3@users.sourceforge.net>
 <alpine.DEB.2.20.1802171842050.2205@hadrien>
 <d6ebe937-81ef-5556-7d00-f7b914521608@users.sourceforge.net>
 <alpine.DEB.2.20.1802171915480.10939@hadrien>
 <81e498d6-294a-8542-9338-50ca8e96303c@users.sourceforge.net>
Message-ID: <alpine.DEB.2.20.1802172005000.10939@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Sat, 17 Feb 2018, SF Markus Elfring wrote:

> >> I guess that it covers only a part of the desired search automation.
> >> The generic handling of variations in parameter positions is
> >> more challenging, isn't it?
> >
> > With iteration you can collect some information on one pass and use it on
> > another pass.  This is discussed in the following set of slides:
> > http://coccinelle.lip6.fr/papers/cocciwk4_talk2.pdf
>
> It would be nice if a function database will be usable.
> Database queries can group the involved function names to some degree.

You can write python code to do whatever you want.

julia
