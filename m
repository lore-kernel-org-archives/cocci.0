From: cardoe@cardoe.com (Doug Goldstein)
Date: Sat, 6 Feb 2016 14:18:46 -0600
Subject: [Cocci] [Xen-devel] [PATCH 2/9] Use
 gnutls_priority_set_direct() to deprecate gnutls_*_set()
In-Reply-To: <20160206040322.GB25240@wotan.suse.de>
References: <1448041672-3986-1-git-send-email-mcgrof@do-not-panic.com>
 <1448041672-3986-3-git-send-email-mcgrof@do-not-panic.com>
 <20151125145322.GA24630@x230.dumpdata.com>
 <20151125193651.GH9528@wotan.suse.de>
 <20151125204420.GA20267@x230.dumpdata.com>
 <20160206014454.GA25240@wotan.suse.de>
 <20160206034554.GA14513@localhost.localdomain>
 <20160206040322.GB25240@wotan.suse.de>
Message-ID: <56B65526.3060002@cardoe.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On 2/5/16 10:03 PM, Luis R. Rodriguez wrote:
> On Fri, Feb 05, 2016 at 10:45:54PM -0500, Konrad Rzeszutek Wilk wrote:
>> On Sat, Feb 06, 2016 at 02:44:54AM +0100, Luis R. Rodriguez wrote:
>>> On Wed, Nov 25, 2015 at 03:44:30PM -0500, Konrad Rzeszutek Wilk wrote:
>>>> On Wed, Nov 25, 2015 at 08:36:51PM +0100, Luis R. Rodriguez wrote:
>>>>> On Wed, Nov 25, 2015 at 09:53:27AM -0500, Konrad Rzeszutek Wilk wrote:
>>>>>> On Fri, Nov 20, 2015 at 09:47:45AM -0800, Luis R. Rodriguez wrote:
>>>>>>> From: "Luis R. Rodriguez" <mcgrof@suse.com>
>>>>>>>
>>>>>>> Using deprecate gnutls_*_set() triggers a failure to compile
>>>>>>> with gnutls30-3.4.4, used on OpenSUSE factory:
>>>>>>>
>>>>>>> ../libqemu_common.a(vnc.o): In function `vnc_start_tls':
>>>>>>> ~/devel/xen/tools/qemu-xen-traditional-dir/vnc.c:2164: undefined reference to `gnutls_kx_set_priority'
>>>>>>> ~/devel/xen/tools/qemu-xen-traditional-dir/vnc.c:2171: undefined reference to `gnutls_certificate_type_set_priority'
>>>>>>> ~/devel/xen/tools/qemu-xen-traditional-dir/vnc.c:2178: undefined reference to `gnutls_protocol_set_priority'
>>>>>>>
>>>>>>> This compilation issue can be fixed by using the new routine
>>>>>>> gnutls_priority_set_direct() which replaces the deprecated calls
>>>>>>> which also simplifies the code considerably.
>>>>>>
>>>>>>
>>>>>> Thanks for posting that! It certainly fixes that issue.
>>>>>
>>>>> Acked-by?
>>>>
>>>> Tested-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
>>>
>>> None of these are merged yet...
>>
>> And it looks like you didn't CC the maintainer.
> 
> mcgrof at garbanzo ~/devel/xen (git::staging)$ ./scripts/get_maintainer.pl ../xen-fixes/0002-proper-qemu-trad-gnutls.patch 
> Ian Campbell <ian.campbell@citrix.com>
> Ian Jackson <ian.jackson@eu.citrix.com>
> Jan Beulich <jbeulich@suse.com>
> Keir Fraser <keir@xen.org>
> Tim Deegan <tim@xen.org>
> xen-devel at lists.xen.org
> 
> I missed Ian Jackson, Keir and Tim.
> 
>> Also - how does this work if you have an older version of SuSE,
>> say SLES10?
> 
> Beats me. I just dealt with getting this to compile with what is current.
> I kind of doubt what is in xen master or staging will end up in SLE10's
> version of Xen too. If that had to happen people porting this to an old
> library could just add a helper gnutls_priority_set_direct() wrapper to
> do things the old way.
> 
>   Luis
> 

I'd personally love to know what's the real minimum that needs to be
supported by Xen master/staging. I tried [1] to put a line in the sand
but that died. I'm also in the process on standing up some basic build
CI [2] and as part of that I would build on new stuff and build on the
oldest set that's supported.

[1]
http://lists.xenproject.org/archives/html/xen-devel/2016-01/msg03577.html
[2]
http://lists.xenproject.org/archives/html/xen-devel/2016-02/msg00984.html

-- 
Doug Goldstein

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 959 bytes
Desc: OpenPGP digital signature
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20160206/1c189064/attachment-0001.asc>
