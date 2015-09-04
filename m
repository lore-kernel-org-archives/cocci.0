From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Fri, 4 Sep 2015 16:15:32 +0200
Subject: [Cocci] Handling of sub-packages by autoconf interfaces
In-Reply-To: <20150904122620.GA8717@pl-59055.rocqadm.inria.fr>
References: <20150903140906.GA9379@pl-59055.rocqadm.inria.fr>
 <55E98987.9010300@redhat.com>
 <20150904122620.GA8717@pl-59055.rocqadm.inria.fr>
Message-ID: <55E9A784.4030106@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> I think the bundle approach is favoured because the Objective Camllanguage
> and its libraries are not as widespread as gettext and libtool.
> So the idea of the bundles is tomake life of end-users simpler,
> but of course it also makes thelifeofdevelopers and maintainers
> a bit harder.

The corresponding software development challenges can be manageable,
can't they?


>>> Then, assuming we continue to bundle the dependencies, it seems to me
>>> that it would be more coherent to have the configure script of each
>>> required bundle run by the tool's main configure script. I am aware of
>>> the AC_CONFIG_SUBDIRS macro, but this seems a bit limited to me. For
>>> instance it means that the sub-package's configure may find a different
>>> compiler to use than the one found by the main conigure, which is not good.
>>
>> I'm not sure why you think a different compiler would be picked for a
>> sub-package. [...]
> 
> Because that already happened. ;-)
> 
> The thing is that the macros to detect the OCaml compiler and the
> associated tools are not yet included in autoconf. So we provide them in
> the tool I am responsible for, and it turns out that one o the bundled
> library provides them, too, but in a different version.

This is an interesting package detail.


> And the twoversions of the macro found different compilers.

Do the package requirements need another look?


> So things are not as standard and straightforward for OCaml as they are
> for C-like languages.

I imagine that further version surprises can happen also with more popular
programming languages if deeper component hierarchies will be considered.
How often do you need to take special care for changes around application
binary interfaces?


>> If you can come up with appropriate shell code to do that, then you can
>> embed that shell code in your configure.ac. I don't know of any autoconf
>> macros that would automate some of the work, but it sounds like it might
>> be something that could be cobbled together, if you still want to go the
>> route of shipping dependent library bundles.
> 
> Thanks. I indeed think it should be possible to achieve this.

I am curious if a bit more momentum will evolve to improve the affected
build scripts.


> As I said I would personally prefer not to bundle libraries but I'm not
> in a position where I can take this decision.

Are there any distribution situations where software bundling is
finally unavoidable?

Regards,
Markus
