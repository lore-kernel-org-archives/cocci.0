From: joe@perches.com (Joe Perches)
Date: Fri, 18 Oct 2013 22:19:56 -0700
Subject: [Cocci] Question: transform function prototypes with non const
 struct pointers to const?
Message-ID: <1382159996.2041.20.camel@joe-AO722>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Any ideas on how to trace call graphs to determine when
struct pointer arguments can be converted from non const
to const?
