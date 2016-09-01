From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Thu, 1 Sep 2016 09:45:40 +0200
Subject: [Cocci] Querying Git commits with Prequel
In-Reply-To: <alpine.DEB.2.10.1608291736460.2984@hadrien>
References: <alpine.DEB.2.10.1608291736460.2984@hadrien>
Message-ID: <2ab7c81b-852a-b090-6ea6-54906d7bab30@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> Prequel is like Coccinelle, but for searching in Git commit histories.

I am curious on how this software approach will evolve further.


> http://prequel-pql.gforge.inria.fr/
> 
> Feedback is welcome.

I pick your offer up now.

Thus I have read your research report 8918 (Prequel: A Patch-Like Query Language
for Commit History Search) to some degree.

1. I imagine that the activities behind the description for a chapter like
"5 Compilation of PQL into SmPL" triggered some development challenges.

   Does an interface exists to view the generated SmPL source code?

2. Did this new query language influence further improvements for the semantic
   patch language?

   * Did the error reporting become a bit safer by this command usage?

   * How much will the data format flexibility evolve together with the handling
     of a key word like "flexible" for metavariables?

3. I get concerns from the section "5.2 Idealized syntax".
   How would you categorise it according to the Chomsky-Sch?tzenberger hierarchy?

4. How many means do you offer to restrict commit ranges according to the section
   "6.1 Commit selection"?

5. Can the combination of words like "token" and "regular expression"
   be occasionally confusing?

6. How interesting will discussions become around the used hardware
   that is mentioned in the chapter "7 Evaluation" and the corresponding
   software performance?

7. How is the status for function and class libraries for this application domain?

Regards,
Markus
