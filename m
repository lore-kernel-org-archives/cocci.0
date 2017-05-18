From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Thu, 18 May 2017 18:00:14 +0200
Subject: [Cocci] Checking failure predicates with SmPL
In-Reply-To: <c77fb009-04c5-c381-e016-549cd7592059@users.sourceforge.net>
References: <c77fb009-04c5-c381-e016-549cd7592059@users.sourceforge.net>
Message-ID: <b961185e-575d-dd8c-23d7-23a66e5ab1a3@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

>  var = action(...);
>  if (failed(var))

This SmPL specification contains a few further software development challenges.

1. It could be taken into account that a function call and a corresponding check
   for the return value are not directly next to each other.
   A SmPL ellipsis could be added there. But I guess that special restrictions
   will be needed then for a safe ?when specification?.

2. The check which should appropriately be performed for a return code depends
   on the called function.
   * Each failure predicate could be written as a separate SmPL rule.
     This approach would result into code duplication to some degree.

   * I would prefer to keep the selection and data processing for the desired
     predicate at a single place. But I am unsure so far how good such a variant
     is supported by the current Coccinelle software.

Regards,
Markus
