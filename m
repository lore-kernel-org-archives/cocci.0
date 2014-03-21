From: peter.senna@gmail.com (Peter Senna Tschudin)
Date: Fri, 21 Mar 2014 11:59:52 +0100
Subject: [Cocci] [ldup-devel] question about "Compile spatch with OCaml
 version >= 3.11"
In-Reply-To: <bd9de990d7744ea497ff9a33d7ab0719@BL2PR03MB404.namprd03.prod.outlook.com>
References: <71b57613e06c4c75a6f14366fa6677ff@BL2PR03MB404.namprd03.prod.outlook.com>
 <CA+MoWDrYeDrgU-POzLZ_1NCKDVBi7M0nXtirAQY8VWLiw_GEkg@mail.gmail.com>
 <c9c2312cd5de4b69bb720e34be20f302@BL2PR03MB404.namprd03.prod.outlook.com>
 <bd9de990d7744ea497ff9a33d7ab0719@BL2PR03MB404.namprd03.prod.outlook.com>
Message-ID: <CA+MoWDqoF_9GwSC6O-v952_CMaVJfXPSjH7FLm8puoRDS9gxRA@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Can you send me the file config.log created by the configure script?

Also, which distribution are you using, and how the build dependencies were met?

On Fri, Mar 21, 2014 at 4:02 AM, Xing Lei <xing.lei@freescale.com> wrote:
> Detailed installation log had been attached, what's more, I had attached the total analysis with coccinelle.
>
> Hope those would help for you. Thanks again.
>
> B.R.
> Xing
>
> -----Original Message-----
> From: ldup-devel-bounces at gforge.freescale.net [mailto:ldup-devel-bounces at gforge.freescale.net] On Behalf Of Xing Lei
> Sent: Friday, March 21, 2014 10:46 AM
> To: Peter Senna Tschudin
> Cc: ldup-devel at gforge.freescale.net; cocci at systeme.lip6.fr; Bucur Madalin-Cristian-B32716
> Subject: Re: [ldup-devel] [Cocci] question about "Compile spatch with OCaml version >= 3.11"
>
> Hello Peter,
>
> Thanks for your support.
> I had tried to reinstall coccinelle following your instructions, only to meet the error as below:
>
> [snip]
> /usr/local/bin/ocamlc -unsafe -I ../commons -I ../commons/ocamlextra -I ../globals -I ../parsing_cocci -I ../parsing_c -I ../engine -c no_prepare_ocamlcocci.ml File "no_prepare_ocamlcocci.ml", line 12, characters 5-57:
> Error: The constructor Ast_cocci.InitialScriptRule expects 5 argument(s),
>        but is applied here to 4 argument(s)
> make[5]: *** [no_prepare_ocamlcocci.cmo] Error 2
> make[5]: Leaving directory `/tmp/coccinelle-1.0.0-rc20/ocaml'
> make[4]: *** [ocaml.all] Error 2
> make[4]: Leaving directory `/tmp/coccinelle-1.0.0-rc20'
> make[3]: *** [subdirs.all] Error 1
> make[3]: Leaving directory `/tmp/coccinelle-1.0.0-rc20'
> make[2]: *** [byte] Error 2
> make[2]: Leaving directory `/tmp/coccinelle-1.0.0-rc20'
> make[1]: *** [all-release] Error 2
> make[1]: Leaving directory `/tmp/coccinelle-1.0.0-rc20'
> make: *** [all] Error 2
>
>
> How to resolve it? Thanks.
>
> Best Regards
> Xing
>
>
> -----Original Message-----
> From: Peter Senna Tschudin [mailto:peter.senna at gmail.com]
> Sent: Thursday, March 20, 2014 11:43 PM
> To: Lei Xing-B45279
> Cc: cocci at systeme.lip6.fr; Bucur Madalin-Cristian-B32716
> Subject: Re: [Cocci] question about "Compile spatch with OCaml version >= 3.11"
>
> On Thu, Mar 20, 2014 at 8:37 AM, Xing Lei <xing.lei@freescale.com> wrote:
>> Hello Engineers of Cocci,
>>
>>
>>
>> I'm an engineer of Freescale. I had met some problems while analyzing
>> code with coccinelle. Executed 'make coccicheck MODE=report
>> M=drivers/net/ethernet/freescale' to analyze part of kernel code,
>> actually I can get some useful analysis but some error info as well,
>> the error info as
>> below:
>>
>>
>>
>> make coccicheck MODE=report M=drivers/net/ethernet/freescale
>>
>>
>>
>> Please check for false positives in the output before submitting a patch.
>>
>> When using "patch" mode, carefully review the patch before submitting it.
>>
>>
>>
>> drivers/net/ethernet/freescale/fman/Peripherals/FM/fm_muram.c:88:13-20:
>> WARNING: kzalloc should be used for p_FmMuram, instead of
>> kmalloc/memset
>>
>> drivers/net/ethernet/freescale/fman/Peripherals/FM/fm.c:1494:8-15: WARNING:
>> kzalloc should be used for p_Fm, instead of kmalloc/memset
>>
>> drivers/net/ethernet/freescale/fman/Peripherals/FM/fm.c:1501:25-32: WARNING:
>> kzalloc should be used for p_Fm -> p_FmStateStruct, instead of
>> kmalloc/memset
>>
>> [snip]
>>
>> Fatal error: exception Failure("OCaml scripting is unsupported.
>> Compile spatch with OCaml version >= 3.11")
>>
>> Fatal error: exception Failure("OCaml scripting is unsupported.
>> Compile spatch with OCaml version >= 3.11")
>>
>> [snip]
>>
>>
>>
>> BTW. Ocaml's version on my machine is 3.12.
>>
>> Could you please give me some suggestions for it? Many thanks.
> The error message suggests that Coccinelle version you are using has been compiled without OCaml support. You can try to compile Coccinelle locally to fix this issue. Here are some simplified instructions:
>
> # 0 Remove currently installed Coccinelle # Fedora / Centos / RedHat $ sudo yum remove coccinelle # Debian / Ubuntu $ sudo apt-get remove coccinelle
>
> # 1 Install build dependencies:
> # Fedora / Centos / RedHat
> $ sudo yum-builddep coccinelle
> # Debian / Ubuntu
> $ sudo apt-get build-dep coccinelle
>
> # 2 - Download and uncompress Coccinelle source code:
> $ cd /tmp
> $ wget http://coccinelle.lip6.fr/distrib/coccinelle-1.0.0-rc20.tgz
> $ tar xzf coccinelle-1.0.0-rc20.tgz
> $ cd coccinelle-1.0.0-rc20
>
> # 3 - Configure, make and install
> $ ./configure --enable-release
> $ make all
> $ sudo make install
>
> If all goes right, the error will not be shown anymore.
>
>>
>>
>>
>> Best Regards
>>
>> Xing
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>> _______________________________________________
>> Cocci mailing list
>> Cocci at systeme.lip6.fr
>> https://systeme.lip6.fr/mailman/listinfo/cocci
>>
>
>
>
> --
> Peter
>
>
>
>
> _______________________________________________
> ldup-devel mailing list
> ldup-devel at gforge.freescale.net
> http://gforge.freescale.net/mailman/listinfo/ldup-devel
>



-- 
Peter
