Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29DB0C433F5
	for <cocci@archiver.kernel.org>; Fri, 25 Feb 2022 15:30:15 +0000 (UTC)
X-IronPort-AV: E=Sophos;i="5.90,136,1643670000"; 
   d="scan'208";a="23255346"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Feb 2022 16:30:14 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 1D537E0382; Fri, 25 Feb 2022 16:30:14 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 60423E0092
	for <cocci@sympa.inria.fr>; Thu, 24 Feb 2022 01:41:14 +0100 (CET)
Authentication-Results: mail3-smtp-sop.national.inria.fr; spf=None smtp.pra=morgangreen@hotmail.com; spf=Pass smtp.mailfrom=morgangreen@hotmail.com; spf=Pass smtp.helo=postmaster@NAM11-BN8-obe.outbound.protection.outlook.com
IronPort-SDR: Ds1OBtslwDRsCwPwhanVJqYrVEWr3Q4f18X1pWeAxksaJCUaAUsaFZy3+fH7X097Bc7ra0ZMF3
 pNqdur56lumA4wc5wF2+bOnom9tq9+ruuayzJ6CG632ujxeMAkY2e1/aZseo68Xp8mRsOuv+RY
 agHB5Qj5BvLou+WQUgsA+frSTlMlSEkGTEmWNxNiCLTSaA5cDPWHmGFqHwe0CZeUtiiyFNhbUg
 +bhBiMc5aIIEaQavKooC4D0YusmXY+hI39BYErFfVE6bXop+Nryx3Pz0GPIucQOC4ZaPeiz/K/
 SbjbSz3jriyb5csCCOrqsb7s
X-IPAS-Result: =?us-ascii?q?A0A1AwAE0xZih08UXChaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?VozgR9WgUYQJwMHS4RUg0sBAYU5iBEDgwGIIoEEhhCMHwsBAwELAQFBBAEBh?=
 =?us-ascii?q?QcChA0fBgEERwECBAEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBAgMEARMBAQEMD?=
 =?us-ascii?q?QkFCAoHDhAFZmVdAYFOAYFYBgMxDYI1KQGDZAEBAQMSERUIAQE3AQ8LGAICJ?=
 =?us-ascii?q?gICMiUGDQgBAQQagmKCZQEDLwKhCQGBOgICixeBFQUBFoEBgggBAQaERwEjK?=
 =?us-ascii?q?ANxgVsJCQGBBiyOQ0OBSUSBWIJnPoRegn83gi6UbYEVAYIoIh46kjuOZ2CcW?=
 =?us-ascii?q?4EuXoJzDwGBLwueOBWZWY49lk6mSgIEAgQFAg4BAQY1gUSBfTMaI4M5TgECA?=
 =?us-ascii?q?QEBDQECAQEDAQIBAQEJAQEBAY4dDA0Jg1CKfyEzOAIGCwEBAwmSLl0BAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 dywjTI84K8JUHvanYwUd1lt2pSlPfmPYdc=
IronPort-HdrOrdr: A9a23:1TG1/am9hIfmnHdu0VLVHKZkkQ7pDfP5imdD5ihNYBxZY6Wkfp
 +V8cjzhCWftN9OYhodcB67Sc69qADnhPtICO4qTM2ftWjdyRCVxeRZgbcKrAeBJ8STzJ8l6U
 4kSdkHNDSSNykKsS+Z2miF+r8bqbHpnpxAx92uqUuFJTsaFJ2IhD0JaDpzfHcGIDWuSaBJd6
 Z1saF81kadUEVSSv7+KmgOXuDFqdGOvJX6YSQeDxpizAWVlzun5JPzDhDdh34lInpy6IZn1V
 KAvx3y562lvf3+4hjA11XL55ATvNf60NNMCOGFl8BQADTxjQSDYphnRtS5zUYIidDqzGxvvM
 jHoh8mMcg2wWjWZHuJrRzk3BSl+Coy6lf5oGXozEfLkIjcfnYXGsBBjYVWfl/y8Ew7puxx16
 pNwiawq4dXNxXdhy7wjuK4HS2CrnDE7kbKrNRjwUC3ELFuI4O5lLZvsH+8Xf87bWPHAOlNKp
 gfMCiT3ocXTbqgVQGqgoBe+q3eYp0NJGbyfqEjgL3g79EEpgEP86N3qfZv4EvosqhNA6WtOI
 7/Q9lVqI0=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.88,392,1635199200"; 
   d="scan'208";a="6806015"
X-MGA-submission: =?us-ascii?q?MDGCukgtzD5HP+lH65bScjgRA4xPGMljmbsvfk?=
 =?us-ascii?q?co4NDAHtz16BpTeBod+N+ZGXDziaw2wwboKO2hnex1yapQRgBTUpyyjB?=
 =?us-ascii?q?9PjNG571D42dlMFKfRaWhmCOPlW4E/cm9k2YqqRf6si8r4bm3Df6gelP?=
 =?us-ascii?q?CtZEtzEYO1Xfzop0v0fcuLjA=3D=3D?=
Received: from mail-bn8nam11olkn2079.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([40.92.20.79])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2022 01:41:13 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M3fkatVUxgc/oII4HJRoxTujN7aXs4eB+UizT3xRjtI/LfMYw5THipcDrqwHUjMkZ3DFeZQd1cVtJ5jdzWx0duJLomCxacAHWAsvmImp1qBqqYUXWqosv3Lql9OcQR6E2mOMpWBxr8aAO0tObM9ivVu9A/s43h89kJmPxXtFvOhkSys6pPp7vluI0A9KqRH3t59eYZSLgDKLEEsii4vT/V5WcUCGAIvaL2rtGEws6CfL5x4DdDIexp+it3L/RIi+1knffX7ume44Ai/xhHnFuHH1UEyAjBYMTOLc88JKyY+Z2MRgEyVcOPSHY6Dc/rKiusB4Gknyn3YgnOu+gN+aDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ch2CgsMOhpo5Q7p3Aiv+QrLIFiiI99DEZP1v0OAghbo=;
 b=QUZs3qNsVogVX5XNe2Inm4Buv62pU37fNVO74ESnrnp2fUrNJsGSArLtbkYNHj2uUAG0hk9ARQQLDPLED6TAgzeywUr/ZikVls+4PIvMYQKXZ8Tr9GuGDDBmx5zdL9Lmb/Vm0rkB5YgaIX9cE3Ve/yaXHf5wLUw88N5B0ZReoXfb3gU39rbuTWQOFxR5ka6UuOXl89KFcLqCVwFmTnt7cB/0jdqvLERPnET2GBTlir2wP8+spkamHpQPLrw3GgtcfDoP/U1GsI5Y1UH9+UjLyxj1Dz/eFaN/xsRogt4zInwCg3EB1AVd+yegUqi02XlN9hv80jcuKLsPqQbBihaHLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ch2CgsMOhpo5Q7p3Aiv+QrLIFiiI99DEZP1v0OAghbo=;
 b=mJ3mn3Ep5uCX+laqWna10QkNFv7VjY5jBELNQ7C3jWJXZtkSEZn8yiqof0bTj7CvDddFzcEbIW96SMkUzx6uU1aGHyAesWT+fsHmQOgf+FdyPJScxkSdEHRbOCgPkTnWhCkUMsCMGUu+7OkYj0kJ3BFMqUsnEeW3VuXWU6MScN6tOy60Ie2lRoCZ5DLeQ7/IsHikavVTzgcvhRidBKQAuv5uA9U1XHcR1YtbldI9LDZ8wyH8G1wOJ3xWtzEzXTaqg7Yp1PbbmoqJWvbpr+PwBOZeOIi1bgLcIpMgwwvNQHbSsXoWjDJOnDF376PL6/2elSEhtaU8Y0tBRKCLkZ5cfQ==
Received: from DS7PR19MB5853.namprd19.prod.outlook.com (2603:10b6:8:78::17) by
 BY5PR19MB3336.namprd19.prod.outlook.com (2603:10b6:a03:187::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.24; Thu, 24 Feb
 2022 00:41:09 +0000
Received: from DS7PR19MB5853.namprd19.prod.outlook.com
 ([fe80::b0a1:26e0:7bde:f54]) by DS7PR19MB5853.namprd19.prod.outlook.com
 ([fe80::b0a1:26e0:7bde:f54%7]) with mapi id 15.20.4995.027; Thu, 24 Feb 2022
 00:41:09 +0000
Message-ID:
 <DS7PR19MB5853AF4DE6594A95E85A358CAC3D9@DS7PR19MB5853.namprd19.prod.outlook.com>
Date: Wed, 23 Feb 2022 16:41:05 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To: Julia Lawall <julia.lawall@inria.fr>
Cc: "cocci@inria.fr" <cocci@inria.fr>
References: <DS7PR19MB5853BC1DDFC7F8D92CF26115AC3C9@DS7PR19MB5853.namprd19.prod.outlook.com>
 <alpine.DEB.2.22.394.2202232321140.2977@hadrien>
From: Morgan Green <morgangreen@hotmail.com>
In-Reply-To: <alpine.DEB.2.22.394.2202232321140.2977@hadrien>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN: [a5gUUL0HRHj0AS4iFFTbs1tM3OandUTh]
X-ClientProxiedBy: SJ0PR03CA0360.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::35) To DS7PR19MB5853.namprd19.prod.outlook.com
 (2603:10b6:8:78::17)
X-Microsoft-Original-Message-ID:
 <fbf2afe6-dfaf-daaa-fc8a-f99490cbfec3@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3e2e1f7f-8532-4bac-ef9f-08d9f72e598d
X-MS-TrafficTypeDiagnostic: BY5PR19MB3336:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	pXzjpivhf18TmOe1t4rScfcsRtItM1EjQzq8csO4QT2gXHjNzqPorjOU21SBuzfPSBbi9gWqs9cWC0M/t//Vv2jwq29aZTaSEWZ/D2usEHqoY90vca27MFnGibkYvTEVaFbYj6zNOmhDASpbVNke2vnGDPivo+Cg87hX7o8lEKrjDq+oS12x74ahm87ZCMIxze1dXG8FJyXb9/V5ZHNOfhO7HgyrjeYKCLm2HuvQe1aCL6zGx0dfG2N2bhJoeUpy+IYods/xVL3qkOg7WdyFq3X6GskVGUfMgC4KT/bEm6XLXnO1UCmI438/gwUCsWiR1OvEI1nyRNrZHRsMZFhkJPZdadYU+217TYRloYC18CfkfMI/WkI8kc37VmNADZGmGrhLjdBR6ArZl+/hzOLqngUXb5+LdbNvmvo9m5bB0DA83mdV36JJHMWWrXvCgpmik8V9NExVOow7gWh/u9k1tpLfJfWfN1+fCbZjYCOcODCdQPUYjQ18GWn4KBARH8CTfD4W6DjuMgQQveZFt3jx1I0Q5OxFnIJ4sqA1hv7XPWCr/BqXxc4+5hLTyxzxppYsg58H3X1d5ACszcJ3iymoeQ==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MDFtQlE4QTZaNlhHVUQ2M3VzcjBBVzltVkNTUWh5VTBGL2NqUTRYSWZKOXN6?=
 =?utf-8?B?bVhRWHM3SGxUbWFuazZWWXJCV0U0Vy95QjBEaVhWYUM2VHFsREQ0UjZTT0NM?=
 =?utf-8?B?RHM1T3NLcUFXSDRaUkJRNDl3bmtiVkpWNXJIblcwRG5lbC9qeWdqb3hwSlRL?=
 =?utf-8?B?WHgwYjVTRVhhd0RXVzRoYkZSK0Ivd0MvUFZONHpFVnBVVzBmSjNOZWcwakVW?=
 =?utf-8?B?Slc4c3JkVEhQMXRyYXY1TnZ3eEdMZTBDcHRpa2NBbXRtSEFSaEpEN0pqNEtP?=
 =?utf-8?B?ZjZGODVHNzJJSVVnajB2ajM2cE1SYTJlSEJKNlhjK2ZMSlBuVmRHTU1jcTlD?=
 =?utf-8?B?NjVMNTg5ajNmbjlVQ051aEJPTmFOY1dzZ2lkZU9NeGZkbDFVeGd1Q1h3MTZ6?=
 =?utf-8?B?eWVROUZUalpSMWY0dzVORXZLajRuQTlkRHlscHNDOVFqU3FIVUdIQkxvUm0z?=
 =?utf-8?B?VmlNMk5HODhRU0FPZzlaQ3EvNVJlU1FRME1iNVpyT2tXMXc3ay82T1A0WE9F?=
 =?utf-8?B?UU1qcWE2end1SXRTYTByekhzMmVkQXRBQ1BFWklPUVFYb0V3VE9yOGJuMlR1?=
 =?utf-8?B?Z1h0TVdha1BkWmpLVnBaKzFUdDF5MHk4a0kvbUNJU2MvUzBTWWk4bDYrL0hK?=
 =?utf-8?B?KzVoeTVibFN5Nlp1ZWJLc29iWlJlZzh2Z2w3a0s0YVphcUw4dEprWVdBVWZn?=
 =?utf-8?B?SE1mU0NYcERyN1RPYWhJejFnWGE4d2J5QWtEMTNDd242MFViVlZSb0d3Sktz?=
 =?utf-8?B?eWxia3ZqVlV5ckhiUCt2UFBBODdNZ3VhWlFhUEs4c2xYQVkrRFA4RmdhdnBJ?=
 =?utf-8?B?bnZHbzFoT2F0UHZpY0VQNFdxU0dPaGpjMk9Xay9XUkd3Y3o5eVpKcEYwOHFz?=
 =?utf-8?B?MStZMVpvMmpKempBVmhIQTJ5YWVHSTBNT2dvSkRMTGhZVm1YTVR0cktsOSs5?=
 =?utf-8?B?dFdGVy8ycDFWZHUzNDdIYTBjSE84U00rOUNaVnpja0ZFWWdFVlUxaFRJNVJp?=
 =?utf-8?B?Uk9yRmQxQTNLUFF6NjZ1OXh6MUJHazN0cGN1ZS95VURMYktnVGw0NXlUQTYx?=
 =?utf-8?B?aU9JN2pVTGwrM1Y4Q1pRd0hGblpzakxaOHE2L2ZvQUZNWXhTb1M4QzVtZU9t?=
 =?utf-8?B?eGxWVVhCN3lCaEpNVXVBRXUrY09JNzJIMXN0aVR0TU5HZkJkYmh5TlBsRzE5?=
 =?utf-8?B?dXVTS0NLd3J2WERhYjZFdHkrb3djcURpVkVlSVBybnJkdkZMNk1MRWlQTWZu?=
 =?utf-8?B?T0ZGSnZjMWFTYjcxM0dZdjFqUWdSNmZ0TU50RE1iVXY0WklNZz09?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-e7757.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e2e1f7f-8532-4bac-ef9f-08d9f72e598d
X-MS-Exchange-CrossTenant-AuthSource: DS7PR19MB5853.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2022 00:41:09.6571
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR19MB3336
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] spatch 1.1.1 hang
Reply-To: Morgan Green <morgangreen@hotmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 151
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <mailto:sympa_inria@inria.fr?subject=help>
List-Subscribe: <mailto:sympa_inria@inria.fr?subject=subscribe%20cocci>
List-Unsubscribe: <mailto:sympa_inria@inria.fr?subject=unsubscribe%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <http://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-02/DS7PR19MB5853AF4DE6594A95E85A358CAC3D9%40DS7PR19MB5853.namprd19.prod.outlook.com>



On 2/23/22 14:22, Julia Lawall wrote:
> 
> 
> On Wed, 23 Feb 2022, Morgan Green wrote:
> 
>> In a message earlier today about C++ support I mentioned an unrelated spatch hang. I've now figured out how to reproduce it with a simple C test case:
>>
>> spatch --sp-file test.cocci test.c
>>
>> ---- test.cocci
>> @@ @@
>> {
>> ...
>> - if(1) {
>> + {
>> ...
>> return ...;
>> }
>> - ...
>> }
> 
> I'm not sure what is the goal for the outer brances.
> 
> If you are trying to remove everything until the end of the function, then
> you could try:
> 
> @@ @@
> 
> - if(1) {
> + {
> ...
> return ...;
> }
> - ...
> 

That was the first thing I tried. I found that with that rule the closing brace 
at the end of a function could be deleted. For example this command:

spatch --sp-file test.cocci test.c

with these files:

---- test.cocci
@@ @@
- if(1) {
+ {
...
return ...;
}
- ...
---- test.c
void foo() {
     if(1) {
         return;
     }
}
----

emits a diff that would transform test.c to this:

void foo() {
     {
         return;
     }

With the closing '}' for foo deleted. That seems like a coccinelle bug, but I 
found I could work around it by adding the outer braces to the rule. 
Unfortunately adding the outer braces also seems to trigger the hang.

-Morgan
