From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Thu, 18 May 2017 17:21:22 +0200
Subject: [Cocci] Safe determination of function properties for SmPL
	scripts
In-Reply-To: <c77fb009-04c5-c381-e016-549cd7592059@users.sourceforge.net>
References: <c77fb009-04c5-c381-e016-549cd7592059@users.sourceforge.net>
Message-ID: <c18f5572-4aff-c91d-b261-3a622d3050c3@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> How can the Coccinelle software help any more in such an use case?

This small SmPL script example demonstrates two special selections of functions
by their name. They belong to separate categories then.

* The primary actions should usually provide a return value somehow.

* A call of a function which will not return from its final task is one
  possibility for an error reaction.


Have you got any preferences for the determination and integration of name lists
for functions with the desired properties into the semantic patch language
in a safe way?

Would you dare to query a database table (or view) for such a purpose?

Regards,
Markus
