From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sun, 14 May 2017 17:41:20 +0200
Subject: [Cocci] Checking exception handling implementations with SmPL
Message-ID: <c77fb009-04c5-c381-e016-549cd7592059@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hello,

I would like to check the implementation of exception handling in various
source files. The following script for the semantic patch language tries to
express a few possibilities for such a source code search pattern.


@show_special_reactions@
expression error_code, var;
identifier action =~ "^(?:malloc|strdup)$",
           no_return =~ "[Aa]bort",
           label;
statement es;
@@
 var = action(...);
 if (failed(var))
 {
(
*   return error_code;
|
*   goto label;
|
*   no_return();
)
 }
 else
 es


I find this approach too simple and therefore incomplete. Three well-known
reactions are shown. But there can be more source code before these statements
like further function calls and variable assignments.
We do eventually not know the extra code there and it can also be
generally optional.

How can the Coccinelle software help any more in such an use case?

Regards,
Markus
