From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sat, 19 Oct 2013 16:03:12 +0200 (CEST)
Subject: [Cocci] Question: transform function prototypes with non const
 struct pointers to const?
In-Reply-To: <1382159996.2041.20.camel@joe-AO722>
References: <1382159996.2041.20.camel@joe-AO722>
Message-ID: <alpine.DEB.2.02.1310191559520.2239@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Fri, 18 Oct 2013, Joe Perches wrote:

> Any ideas on how to trace call graphs to determine when
> struct pointer arguments can be converted from non const
> to const?

I'm not sure that it is quite possible at the moment.  You would need to 
use iteration, which means you need to pass function names and argument 
positions from one iteration to another.  These arguments are currently 
limited to identifiers.  A function name is an identifier, but an argument 
position is not, ie the n in the metavariable declaration expression 
list[n] es;

I wonder if what you really want to do is work on the types?  It is more 
approximate, but if values of some type are never assigned, then they can 
be const.

julia
