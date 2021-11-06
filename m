Return-Path: <SRS0=ITTA=PZ=inria.fr=cocci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BE47C433EF
	for <cocci@archiver.kernel.org>; Sat,  6 Nov 2021 15:37:16 +0000 (UTC)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70EA060EB8
	for <cocci@archiver.kernel.org>; Sat,  6 Nov 2021 15:37:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 70EA060EB8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=inria.fr
X-IronPort-AV: E=Sophos;i="5.87,214,1631570400"; 
   d="scan'208";a="2305673"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 06 Nov 2021 16:37:13 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 2C037E006A; Sat,  6 Nov 2021 16:37:13 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id C5579E004C
	for <cocci@sympa.inria.fr>; Sat,  6 Nov 2021 16:37:08 +0100 (CET)
Authentication-Results: mail2-smtp-roc.national.inria.fr; spf=None smtp.pra=Markus.Elfring@web.de; spf=Pass smtp.mailfrom=Markus.Elfring@web.de; spf=None smtp.helo=postmaster@mout.web.de
IronPort-PHdr: =?us-ascii?q?A9a23=3A+bcYhRZ0M8lHzeUmDUwXj1L/LTGd0IqcDmcuAno?=
 =?us-ascii?q?PtbtCf+yZ8oj4OwSHvLMx1gaPBdWQtKkMy7KP9fy6ASpYudfJmUtBWaQEbwUCh?=
 =?us-ascii?q?8QSkl5oK+++Imq/EsTXaTcnFt9JTl5v8iLzG0FUHMHjew+a+SXqvnYdFRrlKAV?=
 =?us-ascii?q?6OPn+FJLMgMSrzeCy/IDYbxlViDanbr5+Mgi6oR/NusQVjodvKKg8wQbNrndUZ?=
 =?us-ascii?q?uha32xlKUyPkxrm+su84Jtv+DlMtvw88MJNTb/0dLkiQ7xCCzQmPWE15Mn1uhT?=
 =?us-ascii?q?GUACC+HgSXHgInxRRGwTK4w30UZn3sivhq+pywzKaMtHsTbA1Qjut8aFmQwL1h?=
 =?us-ascii?q?SgdNj459GbXitFsjK9evRmsqQBzz5LSbYqIL/d1YL/Tcs0GSmpARsZRVjJOAoW?=
 =?us-ascii?q?gb4sUEuENOf9Uo5Thq1cSqBezAxSnCuHyxT9SnnL43qM03OsvHg/bwgIgEdIAv?=
 =?us-ascii?q?3bIo9v6L6oSTeK4wbPUwTnfYf5b2zHw45XIfBA7pvGMWKp9f83Lxkk1FAPFk06?=
 =?us-ascii?q?QopHqMTOR2OQNqWmb7+xvVemyjGMprBt+oiKsxscxkYnFnI0bylTK9SVjwYY1I?=
 =?us-ascii?q?9K4RVV1YNG6C5RcrTyVOJVvT84kXmpntzo0xKcctp6nYCgF1o4nxxjHZvGZc4W?=
 =?us-ascii?q?F7BztWeSTLDp3hn9oZrKxihay/EW+xOPxSNe53VJXoidBnNTCtmwA2hzT5MWDS?=
 =?us-ascii?q?fZw/Eiv1zaM2g7d9u1JJ10/m6TcK54k2LEwl5wTvFzAHiDogkX2irGZdkE+9ui?=
 =?us-ascii?q?v8eTnbbPrrYKfOY9skgzyLLkiltKlDegmLAQDXXKX9fm82bH580D1WLdHg/4sn?=
 =?us-ascii?q?qTWs53WP9kXq6+7DgNPz4ou5BCyBCq83tsCh3kINldFdQqHj4f3P1HOJ+j1DfK?=
 =?us-ascii?q?4g1SxjDdn3f7HMaP6DZnXM3fMjq/tfbd760FC1Ao+1c5T649KBr0bPv7/RE38u?=
 =?us-ascii?q?MbFAhI5KQC5zf7rCNBn2YMfXWKPDLWZMKTXsVKQ4ewgOfOMZIwIuDbmMfQr6Pr?=
 =?us-ascii?q?ujXEjmV8ce6mp0oAaaX6mEft9OUmWfGTjjs8bEWgWpgo+UPDqiFqaXDFPYHa9Q?=
 =?us-ascii?q?74z5jAgBYK9DYbDQ5itj6ab0Ce6GJ1WfGFGBUqWHXfmbYXXE8sLPRyWK9R9kzk?=
 =?us-ascii?q?FUfCLQoUi3Fn6qgXzwbluBvHJ4SBevoC1h/Zv4OiGsBgo9iFvR+mZ3XuMSW48y?=
 =?us-ascii?q?kYBXTwrx+ZSpUJny1GM+bd1ibpUGIoAtLtyTg4mOMuEnKRBANfoV1eEJ4/RIL5?=
 =?us-ascii?q?HatChHC13Ud87hdMDMR4V8zqKkR3JmSanUeZ9f1mjG5E+tK7RjSCZGg=3D=3D?=
IronPort-Data: =?us-ascii?q?A9a23=3AVankMqn930WHkMbQ6J2hqo7o5gw5JERdPkR7XQ2?=
 =?us-ascii?q?eYbTBsI5bpzcByWVKXjvSaPqJNGunettwOoS3oBxTvJHcmII2HQFv3Hw8FHgiR?=
 =?us-ascii?q?ejtVY3IdB+oV8+xBpSeFxw/t512huEtnanYd1eEzvuWGuWn/SYUOZ2gHOKmUbe?=
 =?us-ascii?q?dYn4pH2eIdQ944f5ds75h6mJXqYPha++9kYuaT/z3YDdJ6RYsWo4nw/7rRCdUg?=
 =?us-ascii?q?RjHkGhwUmrSyhx8lAS2e3E9VPrzLEwqRpfyatE88uWSH44vwFwll1418SvBCvv?=
 =?us-ascii?q?9+lr6WkgNX6KUIgWEzHZbM0SgqkIb/GpoiPl9badaMi+7iB3R9zx14PBEr5+tU?=
 =?us-ascii?q?kEEOqPWmeISewZVGWdyMMWq/ZedeiDi75PLp6HBWyKxn6s3VR9e0Zcj0u1wCmp?=
 =?us-ascii?q?P3ecJLSgEKBGFneO/hryhItSALOw3dJywet4L4yQ4i2nNV6N+B8qeHfvevooAm?=
 =?us-ascii?q?mok2ZVnA9L1Yuw1aR5OZTL7ZhFzIHEpCbcqxb/93j2mZ1W0s3qQorcrpXfexkp?=
 =?us-ascii?q?93dDQ3BPuUoTiba1ocoyw/woqPlgVAy328PSazieZtG2hjKnDkEsXnap6+KKQr?=
 =?us-ascii?q?pZXbJ+7nwT/yyH6kXOkrPP/hkPWtxd3NRkP4iR3xUQt3BXDczQ+NiFUZFabsxR?=
 =?us-ascii?q?aV9c4/ygSgO2S4vK83jt1zVTogtKMhBLKeSP2qfEXOoe1ou7U?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AblS5f6lal6F7nb8VUJVd+TH2N1bpDfLG3DAb?=
 =?us-ascii?q?v31ZSRFFG/Fwwfre5cjzsiWE6wr5OUtBpTnuAsK9qB/nn6Kdy7NhWotKPjOIhI?=
 =?us-ascii?q?LYFuBfBOLZqlXd8kvFm9K1vp0PT0ERMrHN5HFB/L7HyTj9PdY85dGNtIi1mObZ?=
 =?us-ascii?q?1B5WPGdXQpAlwQdlLw6RVnRsQgpLD4dRLuv/2uN34xShZFEeZYCDHX8HU+Lf4/?=
 =?us-ascii?q?3H/aiWBCIuNloI6BSqhTjt0aX9EBSTw1MmWy5PqI1SlVT4rw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0AtAABEoIZhhwMP49RaGgEBAQEBAQEBA?=
 =?us-ascii?q?QEDAQEBARIBAQEBAgIBAQEBQIFZgwwVVzoxhEeQZjGeLAsBAwENMA4BAgQBAYU?=
 =?us-ascii?q?CAoJTAh0HAQQ0EwECBBUBAQUBAQECAQMDBAETAQEBDA0OCCcTJIVoDYI1KQGDZ?=
 =?us-ascii?q?AECAgEjBBEIAQERJgEECwsODAImAgJXBg0IAQGCbQGCVAEDDiULqwt/MoEBggg?=
 =?us-ascii?q?BAQaERx8sIlGBWgMGgRAqAY4hJxCBVUSBFScMgnc+gkwXBBiEXoJlkDoUGIEAo?=
 =?us-ascii?q?hedajMHgguBMIE5C4kKlBsGFC2VZA4GkTCWEIx0mTiBeIF9MxokgzhRGQ+OIBm?=
 =?us-ascii?q?EDIRhhUtAMwIBCC0CBgsBAQMJhUcBAYssAQE?=
X-IPAS-Result: =?us-ascii?q?A0AtAABEoIZhhwMP49RaGgEBAQEBAQEBAQEDAQEBARIBAQE?=
 =?us-ascii?q?BAgIBAQEBQIFZgwwVVzoxhEeQZjGeLAsBAwENMA4BAgQBAYUCAoJTAh0HAQQ0E?=
 =?us-ascii?q?wECBBUBAQUBAQECAQMDBAETAQEBDA0OCCcTJIVoDYI1KQGDZAECAgEjBBEIAQE?=
 =?us-ascii?q?RJgEECwsODAImAgJXBg0IAQGCbQGCVAEDDiULqwt/MoEBgggBAQaERx8sIlGBW?=
 =?us-ascii?q?gMGgRAqAY4hJxCBVUSBFScMgnc+gkwXBBiEXoJlkDoUGIEAohedajMHgguBMIE?=
 =?us-ascii?q?5C4kKlBsGFC2VZA4GkTCWEIx0mTiBeIF9MxokgzhRGQ+OIBmEDIRhhUtAMwIBC?=
 =?us-ascii?q?C0CBgsBAQMJhUcBAYssAQE?=
X-IronPort-AV: E=Sophos;i="5.87,214,1631570400"; 
   d="scan'208";a="2305670"
X-MGA-submission: =?us-ascii?q?MDGM/BaoWjSGEGm/dddZ+4DwGYrIAy7KhtqKiF?=
 =?us-ascii?q?AVBZtTA7WrmsbNCzcBmvdJ5xhoiNiIVj4nsOH9tBDyTsM4hGd5l7uD0h?=
 =?us-ascii?q?bVRmP6DwCuQZAEido0Bq9P/V2HYhMFds/Xlu/Ifg07wUTxNSEmSNRt5W?=
 =?us-ascii?q?A9Ry6J72ezDRrV4SGN3CaZpA=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Nov 2021 16:37:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
	s=dbaedf251592; t=1636213027;
	bh=KqgI5urddpewF25SJrxy8CQoW6mGA/WWwlEvuoYc1L0=;
	h=X-UI-Sender-Class:Date:Subject:To:References:Cc:From:In-Reply-To;
	b=kzBwfo/8XJ1vOIzzM0FZ1Wj5XZEvjym0YU5MaR5/wQEpIJ8sb06uB/Hc5fDLQ3/un
	 OBS3Z9PPdyABCmkR0TpxmG44bzWOdx5dP5bGAIEzyIapAkaWaAOX3fofF4KY0HjTCa
	 9wNaAQzWj6Z870JEfHpS3YujNkF9UQmvIJQezix8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.48.167.14]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MFJnh-1mz2wF3Ejp-00Fonj; Sat, 06
 Nov 2021 16:37:06 +0100
Message-ID: <ab280f62-1069-bdb6-00a1-68bdb843e227@web.de>
Date: Sat, 6 Nov 2021 16:36:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-GB
To: Vlastimil Babka <vbabka@suse.cz>
References: <17a7a40f-b736-e0ea-02ae-1b03ef4483bf@suse.cz>
Cc: cocci@inria.fr
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <17a7a40f-b736-e0ea-02ae-1b03ef4483bf@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:JUHr8SUsKPc+AWfsmOHpM28ot175E87qPb/bgMDdLfJThG95g+V
 BnjIAl8OhApnsBNuXHq5a5Fvh9eFxN59f8vU7/NrcfLyqbtq2+IGQ46amyC8EDB9QUYzq+s
 Q2p9H1srVvanu4+6o0bXXcVdd2nf354gsi8PdujVxTOdWnFfrPvJMHdUaBLrCeRWuIFr8j+
 Omf7i5rUf/KbytxUi9UwQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:TUObn0uupw0=:mAdy+7eJjuj4b/s9bCcaGt
 aRqt5AY4GVuvuZRrzsDHa7UjRkRyZ8xriaFK3qBS1fiE+Yyd5g6R+7P2orVERjk8sZbvJ4RhV
 XqYaa39N/tJU9dWz4cS4vknbtQ8lH+UXFoPuVl3Egl50q/+PA6qAFHujI5bUg9ky3KXnRmdhu
 1C2mbragCGda9RNUGn46jWdwFC+K1YL7DDXOBisndEgIZhqmjBT7NsAXWAWJovNxHe4l5OTHG
 r/1sj2MtypZ0p3dlMRbX3jpioWj8tRTrLxwsFoHR8y5FrNRS0yLCEIpwRBM/9nPIM+/zwwTqK
 /aJmtaBQLI7uojbjYc710AJTeEu7DLVjD8ar6pY9O/3s3YUnOAvgtKkNPbobLp4WCcAz20ecM
 caYjMwzypNeXEwGNA5D6Pe/7zHzBsc3CgoFmGFF8UAZQAyTV4yoVOuK2czkcv1hNRxveQsOvs
 MAFXBSoJrwfZGAVZCouwmRtRJcf5pNZekl4ICvcWEtc6RAgWnXbQ8VCvAMXRRt/bWsIvtptkr
 uri/pX52YaLCP351trlUwzmakDrQLqusgvZOgA3HzjC2SEWcCAMC5wAsjEeVnN9RHiPmDzxIS
 OLjJ1O31pe15QY9kIrlRw4Hv7neQs1lbG9rfFAWV5TY/kHRrjONCnaF+EXTpC5DxeVDHgbER5
 uq8Om7pUAsjjfYA1r9Q2kMNPphKgpQ0twjh8jaIXWtS6FueZAy94CtAQfBcFr9cJsheDkKdEA
 pyYiTT73lP7bgApptPxLzHX92yPZtQszm0dyCftcg9eQOQbV0K2Hjx1R/5WU8tvWeuVkn7SWi
 s4nXKVGH8ihPG/a9pAvRwtTtsEg3jTS7f2Au3TVDFCgHmilx+xDMrn/25F6Wz4tzUNPvnlYzc
 hsMNeKaoXFJ8hNn4TSEYrua9W8wG1QAC+LdDNyz2f+oyoPd77vt9na+dnT6+g3FKfHmxkMDio
 BEpgUl2CGeopqdorMFJdU+jT48lipg1xKcZfaJZYnEIA8M3q6uRqHAENAAw/w1ry+prHbsPHq
 RrlMRDgIyV9f/46ULoQ/koWRE7wPweUzOmMS2vTnuQXm48BFZ797AhjafKrgqkjZVA6Tj7AhZ
 uDoap3O9FCEnPg=
Subject: Re: [cocci] mm/slab: mass conversion of struct page to struct slab
 by spatch
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 86
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2021-11/ab280f62-1069-bdb6-00a1-68bdb843e227%40web.de>

> Thanks in advance for any hints!

I have also taken another look at the proposed SmPL script file.
https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/linux.git/diff/slab.cocci?h=slab-struct_slab-v1r8&id=ccd7da3f3888df4acd82448f861445d4593a9fcb

I have noticed then a few opportunities for a bit of fine-tuning
for the presented code according to the semantic patch language.


@convert_callers@
@@
(
(
-account_slab_page
+account_slab
|
-unaccount_slab_page
+unaccount_slab
)
  (
- page
+ slab
  , ...)
|
(
-PageSlabPfmemalloc
+slab_test_pfmemalloc
|
-ClearPageSlabPfmemalloc
+slab_clear_pfmemalloc
)
  (
- page
+ slab
  )
)

@convert_list_entry@
identifier fn =~ "^list_\w*entry(?:_or_null)?";
@@
-page
+slab
       = fn(...,
-          struct page
+          struct slab
            , ...)

@convert_param_struct_page_ptr@
identifier fn;
expression E;
@@
  fn(...,
-   struct page *page
+   struct slab *slab
     , ...)
  {
  <...
(
-page_node
+slab_node
|
-page_slab(page)
+slab
|
(
-page_address
+slab_address
|
-page_size
+slab_size
|
-page_to_nid
+slab_nid
)
  (
- page
+ slab
  )
|
-virt_to_head_page
+virt_to_slab
  (E)
|
-page
+slab
)
  ...>
  }

@convert_param_page_node@
identifier fn;
expression E;
@@
  fn(...,
     int
-       page_node
+       slab_node
     , ...)
  {
  <...
-page_node
+slab_node
  ...>
  }

@remove_slab_page_wrappers@
expression E;
@@
  index_to_obj(...,
-             slab_page(
                         E
-                      )
+             , ...)

@rename_called_function_parameter@
@@
  TODO(...,
-     page
+     slab
       , ...)

@convert_return_struct_page@
identifier fn =~ "^(?:cache_grow_begin|get_(?:valid_)?first_slab)";
expression E;
@@
  static
-struct page *
+struct slab *
  fn(...)
  {
  <...
-slab_page(
            E
-         )
  ...>
  }

@convert_local_struct_page@
identifier fn !~ "^kmem_(?:get|free)pages", tmp;
expression E;
@@
  fn(...)
  {
  <...
(
-struct page *page
+struct slab *slab
  ;
|
-struct page *
+struct slab *
  tmp;
|
-page_slab(page)
+slab
|
  kasan_poison_slab(
-                  page
+                  slab_page(slab)
                   )
|
(
-page_address
+slab_address
|
-page_size
+slab_size
|
-page_to_nid
+slab_nid
)
  (
- page
+ slab
  )
|
-page->pages
+slab->slabs
|
-page = virt_to_head_page
+slab = virt_to_slab
  (E)
|
-page
+slab
)
  ...>
  }


Regards,
Markus
