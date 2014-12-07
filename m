From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sun, 7 Dec 2014 13:38:25 +0100 (CET)
Subject: [Cocci] Finding function implementations that call only a
 single function.
In-Reply-To: <5484414F.4040900@users.sourceforge.net>
References: <5478F848.1080808@users.sourceforge.net>
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
 <alpine.DEB.2.02.1412071244240.2044@localhost6.localdo! main6>
 <5484414F.4040900@users.sourceforge.net>
Message-ID: <alpine.DEB.2.02.1412071337020.2030@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Sun, 7 Dec 2014, SF Markus Elfring wrote:

> > If the return type has no impact on the match, it can be omitted.
> 
> Is another metavariable needed to filter on functions with a non-void
> return type?

I already explained how this should be done.  Match the functions that 
have a void return type, record their positions, and then match the 
functions at other positions.  The first set have void type, the second do 
not.

Of course, you can also tell from the returns, or lack there of, in the 
function whether the function has void return type as well.

julia

> 
> 
> >> When should a filter pattern on function implementations be adapted to
> >> the property that there will be a return value affected (or not)?
> > 
> > I don't understand the question.
> 
> It seems that I need to describe my small SmPL example with more
> drastic words. Would it introduce programming errrors in such an
> application of the semantic patch language?
> 
> Does it contain logical mistakes?
> 
> Regards,
> Markus
> 
