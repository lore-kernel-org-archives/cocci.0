From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Fri, 5 Jan 2018 15:45:06 +0100
Subject: [Cocci] [v3] runchecks: Generalize make C={1,
 2} to support multiple checkers
In-Reply-To: <1515096931.31439.647.camel@oracle.com>
References: <1515096931.31439.647.camel@oracle.com>
Message-ID: <3eced649-7dd2-b353-9e71-3926df844f1d@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> I do feel confident that the benefits of python for this outweighs the drawbacks
> compared to my initial shell script implementation, or using perl or even C.
>
> Further advice on this appreciated,

I got further ideas around this software situation. I am curious on how they fit
to your vision.

One of the challenges for integration of your contribution can also be the
acceptance of corresponding configuration files. There are design choices
available to work with suggested data structures.

How do you think about the develop an official data format specification
for which the shown Python script could be the first reference implementation?
Alternative implementations could be applied on concrete demand.


I would like to add another development concern:

* Do all (Python) classes need to be stored within the same script file so far?

* Do we need to think about structures around plug-ins (or add-ons) already?

Regards,
Markus
