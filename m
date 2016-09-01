From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 1 Sep 2016 09:00:48 +0100 (IST)
Subject: [Cocci] Querying Git commits with Prequel
In-Reply-To: <2ab7c81b-852a-b090-6ea6-54906d7bab30@users.sourceforge.net>
References: <alpine.DEB.2.10.1608291736460.2984@hadrien>
 <2ab7c81b-852a-b090-6ea6-54906d7bab30@users.sourceforge.net>
Message-ID: <alpine.DEB.2.10.1609010857120.3086@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Thu, 1 Sep 2016, SF Markus Elfring wrote:

> > Prequel is like Coccinelle, but for searching in Git commit histories.
>
> I am curious on how this software approach will evolve further.
>
>
> > http://prequel-pql.gforge.inria.fr/
> >
> > Feedback is welcome.
>
> I pick your offer up now.
>
> Thus I have read your research report 8918 (Prequel: A Patch-Like Query Language
> for Commit History Search) to some degree.
>
> 1. I imagine that the activities behind the description for a chapter like
> "5 Compilation of PQL into SmPL" triggered some development challenges.
>
>    Does an interface exists to view the generated SmPL source code?

It goes into the directory specified with the --tmp argument.


>
> 2. Did this new query language influence further improvements for the semantic
>    patch language?
>
>    * Did the error reporting become a bit safer by this command usage?

No.  The code bases are separate,

>    * How much will the data format flexibility evolve together with the handling
>      of a key word like "flexible" for metavariables?

No idea what this means (data format flexibility).

> 3. I get concerns from the section "5.2 Idealized syntax".
>    How would you categorise it according to the Chomsky-Sch?tzenberger hierarchy?

No idea.  It seems like a straightforward BNF.

> 4. How many means do you offer to restrict commit ranges according to the section
>    "6.1 Commit selection"?

The commit range is just X..Y.  X ad Y could be commit ids or tags (v4.0,
for example).

> 5. Can the combination of words like "token" and "regular expression"
>    be occasionally confusing?

Does the word regular expression occur in the paper?

> 6. How interesting will discussions become around the used hardware
>    that is mentioned in the chapter "7 Evaluation" and the corresponding
>    software performance?

Not sure what there is to discuss.

> 7. How is the status for function and class libraries for this application domain?

No idea what this means.

julia
