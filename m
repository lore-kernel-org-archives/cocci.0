From: ohering@suse.de (Olaf Hering)
Date: Mon, 23 May 2016 23:25:32 +0200
Subject: [Cocci] github update
In-Reply-To: <20160523211952.GY11948@wotan.suse.de>
References: <alpine.DEB.2.02.1605222116490.2250@localhost6.localdomain6>
 <20160523163721.GT11948@wotan.suse.de>
 <alpine.DEB.2.02.1605232230510.2052@localhost6.localdomain6>
 <CAB=NE6UA7+tMax4nGoznvGNwuD0VabuOP71zMzs8rmQS_9Ls9Q@mail.gmail.com>
 <alpine.DEB.2.02.1605232246310.2052@localhost6.localdomain6>
 <20160523211952.GY11948@wotan.suse.de>
Message-ID: <8ff005ad-849a-0f67-5ba3-84651687ffa1@suse.de>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hello,

due to the update to ocaml-4.03 and the breakage caused by it, some
packages do not yet build. Please check whats alreaday green and what
still needs work:


https://build.opensuse.org/project/monitor/devel:languages:ocaml

The publishing might take some time, even if the given pkg is green.

Olaf

Am 23.05.2016 um 23:19 schrieb Luis R. Rodriguez:
> On Mon, May 23, 2016 at 10:49:43PM +0200, Julia Lawall wrote:
>>
>>
>> On Mon, 23 May 2016, Luis R. Rodriguez wrote:
>>
>>> On Mon, May 23, 2016 at 1:31 PM, Julia Lawall <julia.lawall@lip6.fr> wrote:
>>>> Could you see if OpenSuse has libpcre-ocaml-dev, and if so install it?
>>>
>>> It doesn't, and nothing quite like it either.
>>
>> Oops :(
>>
>> I found this:
>>
>> http://rpm.pbone.net/index.php3/stat/4/idpl/33152402/dir/opensuse/com/ocaml-pcre-7.1.6-2.d_l_ocaml.3.x86_64.rpm.html
> 
> Thanks, that doesn't work on the latest opensuse, I modified the spec
> file from the SRPM [0] to use the latest release, which seems to be 7.2.3 [1]
> and installed ocaml-rpm-macros and ocaml-findlib-devel to be able to build
> it but it seems that requires an 'ocaml-oasis' [2], downloaded that, tried
> to configure and that seems to require ocamlmod, ocamlify, and some 'odn'
> thing... I give up. Are all these new dependencies really needed ?
> 
> [0] http://rpm.pbone.net/index.php3/stat/26/dist/46/size/83289/name/ocaml-pcre-7.1.6-2.d_l_ocaml.3.src.rpm
> [1] https://opam.ocaml.org/packages/pcre/pcre.7.2.3/
> [2] https://opam.ocaml.org/packages/oasis/oasis.0.4.6/
> 
>   Luis
> 
