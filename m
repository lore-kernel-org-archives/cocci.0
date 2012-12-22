From: rrh@cs.aau.dk (Rene Rydhof Hansen)
Date: Sun, 23 Dec 2012 00:15:27 +0100
Subject: [Cocci] Inter-procedural analysis.
In-Reply-To: <50D6269D.2060702@gmail.com>
References: <50D61A69.106@gmail.com>
 <alpine.DEB.2.02.1212222145390.1954@hadrien>
 <50D6269D.2060702@gmail.com>
Message-ID: <20121223001527.1af9e01b@vidarr>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

[...]

One other thing you might consider is to first look for functions that
acquire the lock and store the (names of) these functions in a
hashtable, e.g., using the ocaml/python scripting capabilities of
Coccinelle, and then use this hashtable to at least reduce the number
of false positives.

It doesn't solve all problems, but it's quick and easy to do.



/rrh

-- 
Rene Rydhof Hansen
email: rrh at cs.aau.dk
