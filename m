From: julia.lawall@lip6.fr (Julia Lawall)
Date: Mon, 28 Aug 2017 17:20:37 +0200 (CEST)
Subject: [Cocci] Addition of support for conjunctions on types
In-Reply-To: <46e6bd2b-5d17-9636-5631-909ad74f7014@users.sourceforge.net>
References: <alpine.DEB.2.20.1708281334400.3266@hadrien>
 <a03956ce-b42c-179d-7b87-956f8238bf42@users.sourceforge.net>
 <alpine.DEB.2.20.1708281650580.3266@hadrien>
 <7bea3743-3342-0b7d-0023-935f350c1bae@users.sourceforge.net>
 <alpine.DEB.2.20.1708281708390.3266@hadrien>
 <46e6bd2b-5d17-9636-5631-909ad74f7014@users.sourceforge.net>
Message-ID: <alpine.DEB.2.20.1708281718260.3266@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Mon, 28 Aug 2017, SF Markus Elfring wrote:

> > I have no idea what information is wanted.
>
> I am looking for descriptions about circumstances under which the metavariable combination
> will be useful by the mentioned SmPL conjunctions.

I still don't understand the question.  Another example is

(
(
struct i
|
union i
)
&
t
)

Now you have one metavariable, t, that stores the whole type, whether it
is a struct or a union.

julia
