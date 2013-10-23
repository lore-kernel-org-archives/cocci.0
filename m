From: mmarek@suse.cz (Michal Marek)
Date: Wed, 23 Oct 2013 16:56:36 +0200
Subject: [Cocci] [PATCH] scripts/coccinelle/api: remove
	devm_request_and_ioremap.cocci
In-Reply-To: <alpine.DEB.2.02.1310061552541.2037@localhost6.localdomain6>
References: <1376562633-16204-1-git-send-email-wsa@the-dreams.de>
 <20131006134921.GA4173@katana>
 <alpine.DEB.2.02.1310061552541.2037@localhost6.localdomain6>
Message-ID: <5267E3A4.40705@suse.cz>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On 6.10.2013 15:53, Julia Lawall wrote:
> On Sun, 6 Oct 2013, Wolfram Sang wrote:
> 
>> On Thu, Aug 15, 2013 at 12:30:25PM +0200, Wolfram Sang wrote:
>>> Use of this function is discouraged in favour of
>>> devm_ioremap_resource(). Don't advertise it.
>>>
>>> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
> 
> Acked-by: Julia Lawall <julia.lawall@lip6.fr>

Applied to kbuild.git#misc now. For some reason, I overlooked the patch
before.

Michal
