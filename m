From: mmarek@suse.com (Michal Marek)
Date: Mon, 26 Oct 2015 22:46:16 +0100
Subject: [Cocci] [PATCH v6] coccinelle: Improve checking for missing
 NULL terminators
In-Reply-To: <alpine.DEB.2.02.1510232135430.2052@localhost6.localdomain6>
References: <1425043313-15844-1-git-send-email-d.granat@samsung.com>
 <1445614266-14609-1-git-send-email-d.granat@samsung.com>
 <alpine.DEB.2.02.1510232135430.2052@localhost6.localdomain6>
Message-ID: <562E9F28.5040409@suse.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Dne 23.10.2015 v 21:35 Julia Lawall napsal(a):
> Acked-by: Julia Lawall <julia.lawall@lip6.fr>
> 
> On Fri, 23 Oct 2015, Daniel Granat wrote:
> 
>> * Extend checking on tables containing structures which are
>>   initialized without specifying member name. Added new tables
>>   for checking: i2c_device_id and platform_device_id.
>>
>> Signed-off-by: Daniel Granat <d.granat@samsung.com>

Applied to kbuild.git#misc.

Michal
