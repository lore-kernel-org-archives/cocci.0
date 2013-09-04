From: Jamal.Khashan@diasemi.com (Jamal Khashan)
Date: Wed, 4 Sep 2013 11:45:27 +0000
Subject: [Cocci] coccinelle-1.0.0-rc18
In-Reply-To: <CA+MoWDqOtoyWg+EZZDnRKxr3bN8xdQngGer6-iz2mT1yPdhY3w@mail.gmail.com>
References: <54AA37D70A06414FB8288E4A5662904A01024F2DD4@NB-EX-MBX01.diasemi.com>
 <alpine.DEB.2.02.1308240806340.1996@localhost6.localdomain6>
 <54AA37D70A06414FB8288E4A5662904A01024F7392@NB-EX-MBX01.diasemi.com>
 <alpine.DEB.2.02.1309021519440.2250@hadrien>
 <54AA37D70A06414FB8288E4A5662904A01024F7599@NB-EX-MBX01.diasemi.com>
 <CA+MoWDqjw2QtZEtrxDzhw6=Fn_+8gd2yhVGnpzWwVQOq7ObiVg@mail.gmail.com>
 <54AA37D70A06414FB8288E4A5662904A01024F7E11@NB-EX-MBX01.diasemi.com>
 <CA+MoWDq8CZ6ga5GtNzs0q7uA9L0-NmTe8r+BT3Z-FMdXmxAG0g@mail.gmail.com>
 <54AA37D70A06414FB8288E4A5662904A01024F7E35@NB-EX-MBX01.diasemi.com>
 <CA+MoWDqOtoyWg+EZZDnRKxr3bN8xdQngGer6-iz2mT1yPdhY3w@mail.gmail.com>
Message-ID: <54AA37D70A06414FB8288E4A5662904A01024F7E6B@NB-EX-MBX01.diasemi.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi Peter,

It worked, ur the man, I sincerely appreciate your help

Thanks and best regards,

Jamal Khashan
Dialog Semiconductors IT Helpdesk
Direct Dial: +49 (0)7021 805 555
Jamal.Khashan at diasemi.com |  www.diasemi.com
Dialog Semiconductor GmbH, Neue Strasse 95, 73230 Kirchheim /Teck, Germany



-----Original Message-----
From: Peter Senna Tschudin [mailto:peter.senna at gmail.com]
Sent: Wednesday, September 04, 2013 1:19 PM
To: Jamal Khashan
Cc: Julia Lawall; cocci at systeme.lip6.fr
Subject: Re: [Cocci] coccinelle-1.0.0-rc18

Looks like that there is one error in the file, there is a missing new line before deb-src...
The content should be one entry / line, like:

deb http://archive.ubuntu.com/ubuntu lucid main universe deb-src http://archive.ubuntu.com/ubuntu lucid main universe

Can you please check that there is one entry / line?

On Wed, Sep 4, 2013 at 1:13 PM, Jamal Khashan <Jamal.Khashan@diasemi.com> wrote:
> Hi Peter,
>
> Thanks again,  here's the output
>
> root:/etc/apt# cat sources.list
> deb http://archive.ubuntu.com/ubuntu lucid main universe deb-src
> http://archive.ubuntu.com/ubuntu lucid main universe root:/etc/apt#
>
> apt-get build-dep coccinelle
> Reading package lists... Done
> Building dependency tree
> Reading state information... Done
> W: Duplicate sources.list entry http://archive.ubuntu.com/ubuntu/
> lucid/main Packages
> (/var/lib/apt/lists/archive.ubuntu.com_ubuntu_dists_lucid_main_binary-
> amd64_Packages)
> W: Duplicate sources.list entry http://archive.ubuntu.com/ubuntu/
> lucid/universe Packages
> (/var/lib/apt/lists/archive.ubuntu.com_ubuntu_dists_lucid_universe_bin
> ary-amd64_Packages)
> W: Duplicate sources.list entry
> http://linux.dell.com/repo/community/deb/latest/  Packages
> (/var/lib/apt/lists/linux.dell.com_repo_community_deb_latest_Packages)
> W: You may want to run apt-get update to correct these problems
> E: You must put some 'source' URIs in your sources.list
> root at swsrvapps-01:/etc/apt# apt-get update
> Get:1 file:  Release.gpg [198B]
> Get:2 file:  Release [337B]
> Ign file:  Packages
> Ign file:  Packages
> Ign http://ppa.launchpad.net lucid Release.gpg Ign
> http://ppa.launchpad.net lucid Release.gpg Ign
> http://ppa.launchpad.net lucid Release.gpg Hit
> http://archive.ubuntu.com lucid Release.gpg
> Get:3 http://ppa.launchpad.net lucid Release.gpg [316B] Ign
> http://ppa.launchpad.net lucid Release.gpg
> Get:4 http://ppa.launchpad.net lucid Release.gpg [316B]
> Get:5 http://ppa.launchpad.net lucid Release.gpg [316B]
> Get:6 http://ppa.launchpad.net lucid Release.gpg [316B] Ign
> http://ppa.launchpad.net lucid Release.gpg Ign
> http://ppa.launchpad.net lucid Release.gpg Ign
> http://ppa.launchpad.net lucid Release Hit http://archive.ubuntu.com
> lucid Release Ign http://ppa.launchpad.net lucid Release Ign
> http://ppa.launchpad.net lucid Release
> Get:7 http://ppa.launchpad.net lucid Release [13.9kB] Ign
> http://ppa.launchpad.net lucid Release Ign http://ppa.launchpad.net
> lucid Release
> Get:8 http://ppa.launchpad.net lucid Release [14.0kB]
> Get:9 http://ppa.launchpad.net lucid Release [13.9kB]
> Get:10 http://ppa.launchpad.net lucid Release [13.9kB] Ign
> http://ppa.launchpad.net lucid Release Ign http://ppa.launchpad.net
> lucid Release Ign http://ppa.launchpad.net lucid/main Packages Ign
> http://ppa.launchpad.net lucid Release Hit http://archive.ubuntu.com
> lucid/main Packages Ign http://ppa.launchpad.net lucid/main Packages
> Ign http://ppa.launchpad.net lucid/main Packages Hit
> http://ppa.launchpad.net lucid/main Packages Ign
> http://ppa.launchpad.net lucid/main Packages Ign
> http://ppa.launchpad.net lucid Release Ign http://ppa.launchpad.net
> lucid Release Ign http://ppa.launchpad.net lucid/main Packages Ign
> http://ppa.launchpad.net lucid/main Packages Hit
> http://archive.ubuntu.com lucid/universe Packages Ign
> http://ppa.launchpad.net lucid/main Packages Hit
> http://ppa.launchpad.net lucid/main Packages Ign
> http://ppa.launchpad.net lucid/main Packages Ign
> http://ppa.launchpad.net lucid/main Packages Ign
> http://ppa.launchpad.net lucid/main Packages Hit
> http://ppa.launchpad.net lucid/main Packages Hit
> http://ppa.launchpad.net lucid/main Packages Ign
> http://ppa.launchpad.net lucid/main Packages Ign
> http://ppa.launchpad.net lucid/main Packages Err
> http://ppa.launchpad.net lucid/main Packages
>   404  Not Found
> Err http://ppa.launchpad.net lucid/main Packages
>   404  Not Found
> Err http://ppa.launchpad.net lucid/main Packages
>   404  Not Found
> Err http://ppa.launchpad.net lucid/main Packages
>   404  Not Found
> Err http://ppa.launchpad.net lucid/main Packages
>   404  Not Found
> Err http://ppa.launchpad.net lucid/main Packages
>   404  Not Found
> Hit http://www.scootersoftware.com stable Release.gpg
> Get:11 http://linux.dell.com  Release.gpg [827B] Hit
> http://www.scootersoftware.com stable Release
> Get:12 http://linux.dell.com  Release [1392B] Ign
> http://linux.dell.com  Release Ign http://www.scootersoftware.com
> stable/non-free Packages Hit http://linux.dell.com  Packages Ign
> http://www.scootersoftware.com stable/non-free Packages Hit
> http://www.scootersoftware.com stable/non-free Packages Fetched 2096B
> in 1s (1800B/s)
> W: GPG error: http://ppa.launchpad.net lucid Release: The following
> signatures couldn't be verified because the public key is not
> available: NO_PUBKEY 2A8E3034D018A4CE
> W: GPG error: http://ppa.launchpad.net lucid Release: The following
> signatures couldn't be verified because the public key is not
> available: NO_PUBKEY 83FBA1751378B444
> W: GPG error: http://ppa.launchpad.net lucid Release: The following
> signatures couldn't be verified because the public key is not
> available: NO_PUBKEY 83FBA1751378B444
> W: GPG error: http://ppa.launchpad.net lucid Release: The following
> signatures couldn't be verified because the public key is not
> available: NO_PUBKEY 1624804B84ACD041
> W: GPG error: http://linux.dell.com  Release: The following signatures
> couldn't be verified because the public key is not available:
> NO_PUBKEY 1285491434D8786F
> W: Failed to fetch
> http://archive.ubuntu.com/ubuntu/dists/lucid/Release  Unable to find
> expected entry  deb-src/binary-amd64/Packages in Meta-index file
> (malformed Release file?)
>
> W: Failed to fetch
> http://ppa.launchpad.net/Coccinelle/ppa/ubuntu/dists/lucid/main/binary
> -amd64/Packages.gz  404  Not Found
>
> W: Failed to fetch
> http://ppa.launchpad.net/coccicheck/ppa/ubuntu/dists/lucid/main/binary
> -amd64/Packages.gz  404  Not Found
>
> W: Failed to fetch
> http://ppa.launchpad.net/cubs/ppa/ubuntu/dists/lucid/main/binary-amd64
> /Packages.gz  404  Not Found
>
> W: Failed to fetch
> http://ppa.launchpad.net/libpycaml-ocaml-dev/ppa/ubuntu/dists/lucid/ma
> in/binary-amd64/Packages.gz  404  Not Found
>
> W: Failed to fetch
> http://ppa.launchpad.net/ocaml-findlib/ppa/ubuntu/dists/lucid/main/bin
> ary-amd64/Packages.gz  404  Not Found
>
> W: Failed to fetch
> http://ppa.launchpad.net/spatch/ppa/ubuntu/dists/lucid/main/binary-amd
> 64/Packages.gz  404  Not Found
>
> E: Some index files failed to download, they have been ignored, or old ones used instead.
> root@:/etc/apt#
>
> Thanks and best regards,
>
> Jamal Khashan
> Dialog Semiconductors IT Helpdesk
> Direct Dial: +49 (0)7021 805 555
> Jamal.Khashan at diasemi.com |  www.diasemi.com Dialog Semiconductor
> GmbH, Neue Strasse 95, 73230 Kirchheim /Teck, Germany
>
>
>
> -----Original Message-----
> From: Peter Senna Tschudin [mailto:peter.senna at gmail.com]
> Sent: Wednesday, September 04, 2013 1:07 PM
> To: Jamal Khashan
> Cc: Julia Lawall; cocci at systeme.lip6.fr
> Subject: Re: [Cocci] coccinelle-1.0.0-rc18
>
> Hi Jamal,
>
> This can be fixed by running:
> $ sudo apt-get build-dep coccinelle
>
> In order to this command to work, you need to enable the official universe repository in the sources.list file. Both for packages and sources. Mine looks like:
>
> $ cat /etc/apt/sources.list
> deb http://archive.ubuntu.com/ubuntu lucid main universe deb-src
> http://archive.ubuntu.com/ubuntu lucid main universe
>
> If you do changes in /etc/apt/sources.list, run `apt-get update` after the changes.
>
> Please let me know if this helped you.
>
> On Wed, Sep 4, 2013 at 1:00 PM, Jamal Khashan <Jamal.Khashan@diasemi.com> wrote:
>> Hi Peter,
>>
>> /coccinelle-1.0.0-rc18# ./configure --enable-release
>> --without-pkg-config
>> configure: configuring coccinelle 1.0.0-rc17 in
>> /root/conf/coccinelle-1.0.0-rc18
>> checking for a BSD-compatible install... /usr/bin/install -c checking
>> whether build environment is sane... yes
>> /root/conf/coccinelle-1.0.0-rc18/setup/missing: Unknown '--is-lightweight'
>> option
>> Try '/root/conf/coccinelle-1.0.0-rc18/setup/missing --help' for more
>> information
>> configure: WARNING: 'missing' script is too old or missing checking
>> for a thread-safe mkdir -p... /bin/mkdir -p checking for gawk... gawk
>> checking whether make sets $(MAKE)... yes checking whether make
>> supports nested variables... yes
>> configure: determining version suffix checking for date... /bin/date
>> configure: version suffix set to Wed, 04 Sep 2013 11:55:21 +0100
>> configure: this configure program uses pkg-config m4 macros
>> configure: this configure program uses ocaml m4 macros (see
>> setup/ocaml.m4)
>> configure: this configure program uses custom m4 macros (see
>> setup/cocci.m4)
>> configure: some fake substitutions for required but unavailable
>> programs may be used (see setup/fake*)
>> configure: verifying basic tools
>> checking for style of include used by make... GNU checking for gcc...
>> gcc checking whether the C compiler works... yes checking for C
>> compiler default output file name... a.out checking for suffix of
>> executables...
>> checking whether we are cross compiling... no checking for suffix of
>> object files... o checking whether we are using the GNU C compiler...
>> yes checking whether gcc accepts -g... yes checking for gcc option to
>> accept ISO C89... none needed checking whether gcc understands -c and
>> -o together... yes checking dependency style of gcc... none checking
>> how to run the C preprocessor... gcc -E checking for bash...
>> /bin/bash checking for tar... /bin/tar checking for patch...
>> /usr/bin/patch checking for echo... /bin/echo checking for
>> patchelf... no
>> configure: pkg-config is disabled explicitly checking for ocamlc...
>> /usr/bin/ocamlc OCaml version is 3.11.2 OCaml library path is
>> /usr/lib/ocaml checking for ocamlopt... /usr/bin/ocamlopt checking
>> for ocamlc.opt... /usr/bin/ocamlc.opt checking for ocamlopt.opt...
>> /usr/bin/ocamlopt.opt checking for ocaml... /usr/bin/ocaml checking
>> for ocamldep... /usr/bin/ocamldep checking for ocamlmktop...
>> /usr/bin/ocamlmktop checking for ocamlmklib... /usr/bin/ocamlmklib
>> checking for ocamldoc... /usr/bin/ocamldoc checking for ocamlbuild...
>> /usr/bin/ocamlbuild checking that the OCaml version is at least
>> 3.10... yes checking that the OCaml version is at least 3.11... yes
>> checking for camlp4... /usr/bin/camlp4 checking for camlp4boot... no
>> checking for camlp4o... /usr/bin/camlp4o checking for camlp4of... no
>> checking for camlp4oof... no checking for camlp4orf... no checking
>> for camlp4prof... no checking for camlp4r... /usr/bin/camlp4r
>> checking for camlp4rf... no checking for ocamllex...
>> /usr/bin/ocamllex checking for ocamllex.opt... /usr/bin/ocamllex.opt checking for ocamlyacc...
>> /usr/bin/ocamlyacc checking for ocamlfind... /usr/bin/ocamlfind
>> checking for ocamlprof... /usr/bin/ocamlprof
>> configure: verifying basic ocaml modules
>> configure: coccinelle may use external ocaml libraries in
>> /root/conf/coccinelle-1.0.0-rc18/bundles
>> configure: the following OCaml packages should be provided by your
>> ocaml installation checking for OCaml findlib package unix... found
>> checking for OCaml findlib package bigarray... found checking for
>> OCaml findlib package num... found checking for OCaml findlib package
>> str... found
>> configure: configuring package dynlink checking for OCaml findlib
>> package dynlink... found
>> configure: configuring package camlp4 checking for OCaml findlib
>> package camlp4... found
>> configure: configuring package menhirLib checking for OCaml findlib
>> package menhirLib... found
>> configure: verifying optional features checking for menhir...
>> /usr/bin/menhir checking for python... /usr/bin/python checking
>> python version... 2.6 found
>> configure: python major version: 2
>> configure: looking for the corresponding python library checking for
>> PYTHON... no
>> configure: trying the default python library as fallback checking for
>> PYTHON... no checking for PCRE... yes
>> configure: configuring package pcre
>> checking for OCaml findlib package pcre... not found
>> configure: OCaml package pcre is not available checking for a bundled
>> substitute of pcre... yes
>> configure: using bundled substitute for pcre in
>> /root/conf/coccinelle-1.0.0-rc18/bundles/pcre/
>> configure: support for pcre syntax is enabled checking for pdflatex...
>> no
>> configure: pdflatex not found. Trying substitute
>> /root/conf/coccinelle-1.0.0-rc18/setup/fake-pdflatex.sh pdflatex.
>> checking for pdflatex...
>> /root/conf/coccinelle-1.0.0-rc18/setup/fake-pdflatex.sh pdflatex
>> configure: the optimized version of coccinelle will not be build by
>> default due to OCaml version 3.11.2 checking that generated files are
>> newer than configure... done
>> configure: creating ./config.status
>> config.status: creating Makefile.config
>> config.status: creating version.ml
>> config.status: creating commons/commands.ml
>> config.status: creating globals/config.ml
>> config.status: creating globals/regexp.ml
>> config.status: creating python/pycocci.ml
>> config.status: creating ocaml/prepare_ocamlcocci.ml
>> config.status: creating scripts/spatch.sh
>> config.status: creating docs/spatch.1
>> config.status: creating myocamlbuild.ml
>> config.status: creating setup/Makefile
>> config.status: executing depfiles commands
>> configure: configuration completed
>> ---------------------------------------------------------------------
>> -
>> --------
>> Summary
>>
>> configure flags:  --enable-release --without-pkg-config
>> findlib:          /usr/bin/ocamlfind    (an actual version is strongly
>> recommended)
>> menhir:           /usr/bin/menhir       (should be an optional tool)
>> menhirLib module: yes   (for local package use --disable-menhirLib)
>>
>> ocaml scripting:  yes   (overridable with --enable-ocaml)
>> python scripting: no    (overridable with --enable-python)
>> pycaml module:          (for local package use --disable-pycaml)
>>
>> pcre regexes:     local (overridable with --enable-pcre-syntax)
>> pcre module:      local (for local package use --disable-pcre)
>> pcre library:     yes   (requires the dev version of libpcre)
>>
>> release config:   yes   (strongly recommended to be 'yes', overridable with
>> --enable-release)
>> optimized spatch: no    (overridable with --disable-opt)
>>
>> ---------------------------------------------------------------------
>> -
>> -------- Coccinelle can now be compiled and installed.
>>
>>
>> If you compile coccinelle again after source code changes or
>> configuration changes, you may need to run first:
>>   $ make clean
>>
>> To compile coccinelle, run:
>>   $ make all
>>
>> To install coccinelle, run:
>>   $ make install
>>
>> Then, to test coccinelle, run for example:
>>   $ spatch -sp_file demos/simple.cocci demos/simple.c -o
>> /tmp/new_simple.c
>>
>> Or when coccinelle is not installed yet:
>>   $ COCCINELLE_HOME=/root/conf/coccinelle-1.0.0-rc18 ./scripts/spatch
>> -sp_file demos/simple.cocci demos/simple.c -o /tmp/new_simple.c
>> ---------------------------------------------------------------------
>> -
>> --------
>> #
>>
>>
>> Thanks and best regards,
>>
>> Jamal Khashan
>> Dialog Semiconductors IT Helpdesk
>> Direct Dial: +49 (0)7021 805 555
>> Jamal.Khashan at diasemi.com |  www.diasemi.com Dialog Semiconductor
>> GmbH, Neue Strasse 95, 73230 Kirchheim /Teck, Germany
>>
>>
>> -----Original Message-----
>> From: Peter Senna Tschudin [mailto:peter.senna at gmail.com]
>> Sent: Tuesday, September 03, 2013 4:45 PM
>> To: Jamal Khashan
>> Cc: Julia Lawall; cocci at systeme.lip6.fr
>> Subject: Re: [Cocci] coccinelle-1.0.0-rc18
>>
>> Hi Jamal,
>>
>> Can you try to configure with:
>>
>> $ ./configure --enable-release --without-pkg-config
>>
>> Thanks,
>>
>> Peter
>> ...
>>
>> On Tue, Sep 3, 2013 at 8:24 AM, Jamal Khashan
>> <Jamal.Khashan@diasemi.com>
>> wrote:
>>> Hi Julia,
>>>
>>> Thanks for your feedback.
>>>
>>> I think this version is a bit old?  Do you have the possibility to
>>> upgrade?
>>> Unfortunately I neither can upgrade Ubuntu nor python per feedback
>>> from my clients as follows " Hi Jamal, I've spoken with several
>>> other engineers and it would be a big risk to update python. We are
>>> using Gitorious (python) which manages all our software version
>>> control, also other people in different teams use python for their
>>> development and I do not know how this would affect those people.
>>> I think that his update would be too risky for us at the moment.
>>> Regards,
>>> Stephen
>>> "
>>>
>>> Can I supply any info, logs, configuration files etc that might
>>> assist in resolving this issue without OS or application upgrade?
>>>
>>>
>>> Thanks and best regards,
>>>
>>> Jamal Khashan
>>> Dialog Semiconductors IT Helpdesk
>>> Direct Dial: +49 (0)7021 805 555
>>> Jamal.Khashan at diasemi.com |  www.diasemi.com Dialog Semiconductor
>>> GmbH, Neue Strasse 95, 73230 Kirchheim /Teck, Germany
>>>
>>>
>>> -----Original Message-----
>>> From: Julia Lawall [mailto:julia.lawall at lip6.fr]
>>> Sent: Monday, September 02, 2013 3:22 PM
>>> To: Jamal Khashan
>>> Cc: 'cocci at systeme.lip6.fr'
>>> Subject: RE: [Cocci] coccinelle-1.0.0-rc18
>>>
>>> On Mon, 2 Sep 2013, Jamal Khashan wrote:
>>>
>>>> Hi Julia,
>>>>
>>>> Thanks for feedback, sorry for the late reply, I was on Vacation
>>>> for a week, but here's the output requested
>>>>
>>>> # lsb_release -a
>>>> No LSB modules are available.
>>>> Distributor ID: Ubuntu
>>>> Description:    Ubuntu 10.04.4 LTS
>>>> Release:        10.04
>>>> Codename:       lucid
>>>> #
>>>
>>> I think this version is a bit old?  Do you have the possibility to
>>> upgrade.
>>> On the other hand, it is the same version that I have at home, so I
>>> can try to reproduce the problem.
>>>
>>>> # pkg-config --exists --print-errors python-2.6 Package python-2.6
>>>> was not found in the pkg-config search path.
>>>> Perhaps you should add the directory containing `python-2.6.pc'
>>>> to the PKG_CONFIG_PATH environment variable No package 'python-2.6'
>>>> found #
>>>
>>> Do you just need to install python 2.6?  Did you install it
>>> separately from ubuntu?
>>>
>>> I don't know much about pkg-config.  Maybe someone else knows why
>>> you might have some software installed but pkg-config can't find it.
>>>
>>> julia
>>>
>>>> Thanks and best regards,
>>>>
>>>> Jamal Khashan
>>>> Dialog Semiconductors IT Helpdesk
>>>> Direct Dial: +49 (0)7021 805 555
>>>> Jamal.Khashan at diasemi.com |  www.diasemi.com Dialog Semiconductor
>>>> GmbH, Neue Strasse 95, 73230 Kirchheim /Teck, Germany
>>>>
>>>>
>>>> -----Original Message-----
>>>> From: Julia Lawall [mailto:julia.lawall at lip6.fr]
>>>> Sent: Saturday, August 24, 2013 8:12 AM
>>>> To: Jamal Khashan
>>>> Cc: 'cocci at systeme.lip6.fr'
>>>> Subject: Re: [Cocci] coccinelle-1.0.0-rc18
>>>>
>>>> > I am having difficulties enabling python scripting with
>>>> > coccinelle-1.0.0-rc18 as follows
>>>>
>>>> What OS/distribution are you using?  Perhaps the problem could be
>>>> that you have python 2.6?  I have 2.7.
>>>>
>>>> Maybe you should try something like
>>>>
>>>> pkg-config --exists --print-errors python-2.6
>>>>
>>>> julia
>>>> ________________________________
>>>>
>>>> Dialog Semiconductor GmbH
>>>> Neue Str. 95
>>>> D-73230 Kirchheim
>>>> Managing Directors: Dr. Jalal Bagherli, Jean-Michel Richard
>>>> Chairman of the Supervisory Board: Gregorio Reyes Commercial register:
>>>> Amtsgericht Stuttgart: HRB 231181 UST-ID-Nr. DE 811121668
>>>>
>>>> Legal Disclaimer: This e-mail communication (and any attachment/s)
>>>> is confidential and contains proprietary information, some or all
>>>> of which may be legally privileged. It is intended solely for the
>>>> use of the individual or entity to which it is addressed. Access to
>>>> this email by anyone else is unauthorized. If you are not the
>>>> intended recipient, any disclosure, copying, distribution or any
>>>> action taken or omitted to be taken in reliance on it, is
>>>> prohibited and may be unlawful.
>>>>
>>>> Please consider the environment before printing this e-mail
>>>>
>>>>
>>>>
>>>
>>>
>>>
>>>   ________________________________
>>>
>>> Dialog Semiconductor GmbH
>>> Neue Str. 95
>>> D-73230 Kirchheim
>>> Managing Directors: Dr. Jalal Bagherli, Jean-Michel Richard Chairman
>>> of the Supervisory Board: Gregorio Reyes Commercial register:
>>> Amtsgericht Stuttgart: HRB 231181 UST-ID-Nr. DE 811121668 Legal
>>> Disclaimer: This e-mail communication (and any attachment/s) is
>>> confidential and contains proprietary information, some or all of
>>> which may be legally privileged. It is intended solely for the use
>>> of the individual or entity to which it is addressed. Access to this
>>> email by anyone else is unauthorized. If you are not the intended
>>> recipient, any disclosure, copying, distribution or any action taken
>>> or omitted to be taken in reliance on it, is prohibited and may be
>>> unlawful.
>>>
>>> Please consider the environment before printing this e-mail
>>>
>>>
>>> _______________________________________________
>>> Cocci mailing list
>>> Cocci at systeme.lip6.fr
>>> https://systeme.lip6.fr/mailman/listinfo/cocci
>>>
>>
>>
>>
>> --
>> Peter
>>
>>
>>
>>   ________________________________
>>
>> Dialog Semiconductor GmbH
>> Neue Str. 95
>> D-73230 Kirchheim
>> Managing Directors: Dr. Jalal Bagherli, Jean-Michel Richard Chairman
>> of the Supervisory Board: Gregorio Reyes Commercial register:
>> Amtsgericht Stuttgart: HRB 231181 UST-ID-Nr. DE 811121668 Legal
>> Disclaimer: This e-mail communication (and any attachment/s) is
>> confidential and contains proprietary information, some or all of
>> which may be legally privileged. It is intended solely for the use of
>> the individual or entity to which it is addressed. Access to this
>> email by anyone else is unauthorized. If you are not the intended
>> recipient, any disclosure, copying, distribution or any action taken
>> or omitted to be taken in reliance on it, is prohibited and may be unlawful.
>>
>> Please consider the environment before printing this e-mail
>>
>
>
>
> --
> Peter
> ________________________________
>
> Dialog Semiconductor GmbH
> Neue Str. 95
> D-73230 Kirchheim
> Managing Directors: Dr. Jalal Bagherli, Jean-Michel Richard Chairman
> of the Supervisory Board: Gregorio Reyes Commercial register:
> Amtsgericht Stuttgart: HRB 231181 UST-ID-Nr. DE 811121668
>
> Legal Disclaimer: This e-mail communication (and any attachment/s) is confidential and contains proprietary information, some or all of which may be legally privileged. It is intended solely for the use of the individual or entity to which it is addressed. Access to this email by anyone else is unauthorized. If you are not the intended recipient, any disclosure, copying, distribution or any action taken or omitted to be taken in reliance on it, is prohibited and may be unlawful.
>
> Please consider the environment before printing this e-mail
>
>



--
Peter
________________________________

Dialog Semiconductor GmbH
Neue Str. 95
D-73230 Kirchheim
Managing Directors: Dr. Jalal Bagherli, Jean-Michel Richard
Chairman of the Supervisory Board: Gregorio Reyes
Commercial register: Amtsgericht Stuttgart: HRB 231181
UST-ID-Nr. DE 811121668

Legal Disclaimer: This e-mail communication (and any attachment/s) is confidential and contains proprietary information, some or all of which may be legally privileged. It is intended solely for the use of the individual or entity to which it is addressed. Access to this email by anyone else is unauthorized. If you are not the intended recipient, any disclosure, copying, distribution or any action taken or omitted to be taken in reliance on it, is prohibited and may be unlawful.

Please consider the environment before printing this e-mail
