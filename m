From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Mon, 6 Jun 2016 18:20:24 +0200
Subject: [Cocci] Further software updates after Coccinelle v1.0.5?
In-Reply-To: <alpine.DEB.2.10.1606061112180.2909@hadrien>
References: <alpine.DEB.2.10.1606061112180.2909@hadrien>
Message-ID: <a48e21fa-cde3-2e85-ee7f-3c8af8de1572@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> Coccinelle v1.0.5 is now available.

Thanks for this software development progress.


* I would appreciate that corresponding changes will become viewable
also by the GitHub interface shortly.

* Would you like to add any comments to open issues like the following?


> * Coccinelle is compatible with the latest release of OCaml, version 4.03.0

Software development challenges around OCaml-SmPL scripting interface
with OCaml (>= 4.02.1 ?)
https://github.com/coccinelle/coccinelle/issues/48


> * Include files are now parse before the .c files that include them (quite
> strangely, they were previously parsed afterwards).  This makes more
> typedef information available when parsing the .c file, and can reduce
> parse errors.

* Was another test case added for this implementation detail?
* Is such header file inclusion still affected by command line parameters?


> * Various improvements in the pretty printing of C code.

Will further considerations evolve around the topic "Make change
influence configurable for coding style rules"?
https://github.com/coccinelle/coccinelle/issues/37


> A more complete list of changes, including to the pycocci wrapper,
> is available here: http://coccinelle.lip6.fr/distrib/changes.html

How do you think about to take another look here?

* Improve application programming interface design around match
management functions
  https://github.com/coccinelle/coccinelle/issues/64

* Fixed: PCRE bundle
 
https://github.com/coccinelle/coccinelle/commit/4ab8c0f230fe5b88c4fda55fba8137fc2e7d3f5d#diff-330c4cdb11d3a4bcb8e1446ed8022389R48

Regards,
Markus
