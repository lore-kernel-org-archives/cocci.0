From: mmarek@suse.com (Michal Marek)
Date: Mon, 20 Jun 2016 17:20:48 +0200
Subject: [Cocci] [PATCH v3] Coccinelle: noderef: Add new rules and
 correct the old rule
In-Reply-To: <alpine.DEB.2.10.1605241038490.2997@hadrien>
References: <1464063557-5176-1-git-send-email-vaishali.thakkar@oracle.com>
 <alpine.DEB.2.10.1605241038490.2997@hadrien>
Message-ID: <576809D0.1010707@suse.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On 2016-05-24 10:39, Julia Lawall wrote:
> Acked-by: Julia Lawall <julia.lawall@lip6.fr>
> 
> On Tue, 24 May 2016, Vaishali Thakkar wrote:
> 
>> Add new rules to detect the cases where sizeof is used in
>> function calls as a argument.
>>
>> Also, for the patch mode third rule should behave same as
>> second rule with arguments reversed. So, change that as well.
>>
>> Signed-off-by: Vaishali Thakkar <vaishali.thakkar@oracle.com>

Applied to kbuild.git#misc.

Michal
