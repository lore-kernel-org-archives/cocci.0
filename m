From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Fri, 4 Sep 2015 08:00:43 +0200
Subject: [Cocci] Handling of sub-packages by autoconf interfaces
In-Reply-To: <20150903140906.GA9379@pl-59055.rocqadm.inria.fr>
References: <20150903140906.GA9379@pl-59055.rocqadm.inria.fr>
Message-ID: <55E9338B.2040106@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> The tool is distributed with the libraries it depends on
> (they are provided as bundles).

This approach is generally fine in principle.


> For each dependency, coccinelle's configure script checks whether the
> library is already installed. If not, the system is prepared to use the
> bundled version.

The configuration interface needs also to be designed in a way so that
a software builder can select the preferred variant.


> This approach does not seem very satisfactory to me.

Interesting ?


> For a start, I find it cumbersome to provide the dependencies as bundles

Is it usual that a working version of a needed software component
is distributed together with your evolving tool?


> but I'm not the person making the decisions.

Would any more maintainers like to share their experiences?


> However, any opinion or pointer about software bundling their dependencies,
> pros and cons and the techniques used to do so would be warmly appreciated.

I assume that you are more looking for general solutions which can make
the involved software management a bit easier and safer.


> Then, assuming we continue to bundle the dependencies, it seems to me
> that it would be more coherent to have the configure script of each
> required bundle run by the tool's main configure script.

You can call another configuration script already if a bundle provides one.


> I am aware of the AC_CONFIG_SUBDIRS macro, but this seems a bit limited to me.
> For instance it means that the sub-package's configure may find a different
> compiler to use than the one found by the main conigure, which is not good.

Would you like to revive discussions around an issue which is described in
a similar way in the article "Autoconf: AC_CONFIG_SUBDIRS With Custom Flags
for Subprojects" by Clemens Lang?
https://neverpanic.de/blog/2014/04/10/autoconf-ac-config-subdirs-with-custom-flags-for-subprojects/


> One other issue is that we bundle the dependencies as .tar.gz archives
> and we would like to be able to extract the archives only for those
> dependencies that will really be needed (because they are not already
> installed on the system).

Did we stumble on similar software management challenges often enough already?

Do any "problems" come from design details like the following?
* How much control have you got on the bundle format for each item?

* Do the involved data formats support the determination of dependencies
  without unpacking the available archives completely?


> Can this be achieved somehow with autoconf?

Partly, yes.

The autoconf software is reusing the programming language "M4".
https://www.gnu.org/savannah-checkouts/gnu/autoconf/manual/autoconf-2.69/html_node/Autoconf-Language.html

It can be extended with libraries as usual.
https://www.gnu.org/software/autoconf-archive/

Regards,
Markus
