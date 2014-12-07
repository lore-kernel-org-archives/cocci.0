From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sun, 7 Dec 2014 12:45:20 +0100 (CET)
Subject: [Cocci] Finding function implementations that call only a
 single function.
In-Reply-To: <54842E04.9060800@users.sourceforge.net>
References: <5478F848.1080808@users.sourceforge.net>
 <54820FEF.4080901@users.sourceforge.net>
 <54834F76.1090104@users.sourceforge.net>
 <alpine.DEB.2.10.1412061955440.2042@hadrien>
 <548358DE.6020409@users.sourceforge.net>
 <alpine.DEB.2.02.1412062139570.2256@localhost6.localdomain6>
 <548371FB.9060402@users.sourceforge.net>
 <alpine.DEB.2.02.1412062219530.2256@localhost6.localdomain6>
 <54837413.8000902@users.sourceforge.net>
 <alpine.DEB.2.02.1412062232470.2256@localhost6.localdomain6>
 <5483806D.3070805@users.sourceforge.net>
 <alpine.DEB.2.02.1412062342540.2256@localhost6.localdomain6>
 <5483902E.8060109@users.sourceforge.net>
 <alpine.DEB.2.02.1412070749130.2044@localhost6.localdomain6>
 <54841AB2.6070609@users.sourceforge.net>
 <alpine.DEB.2.02.1412071027040.2044@localhost6.localdomain6>
 <54842A73.4000203@users.sourceforge.net>
 <alpine.DEB.2.02.1412071125130.2044@localhost6.localdomain6>
 <54842E04.9060800@users.sourceforge.net>
Message-ID: <alpine.DEB.2.02.1412071244240.2044@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Sun, 7 Dec 2014, SF Markus Elfring wrote:

> >> One part of each SmPL disjunction will always not match in this approach
> >> if an analysed function implementation has got the return type "void".
> >> Would the specification of a metavariable "return_type" be also
> >> unnecessary and inappropriate in this use case?
> > 
> > Currently, return_type does absolutely nothing.  You can just drop it.
> 
> Should I really omit to distinguish the function return type?

If the return type has no impact on the match, it can be omitted.

> When should a filter pattern on function implementations be adapted to
> the property that there will be a return value affected (or not)?

I don't understand the question.

julia
