Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BC6AC433EF
	for <cocci@archiver.kernel.org>; Tue,  1 Mar 2022 01:28:28 +0000 (UTC)
X-IronPort-AV: E=Sophos;i="5.90,144,1643670000"; 
   d="scan'208";a="23693863"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 01 Mar 2022 02:28:26 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 5F12EE0382; Tue,  1 Mar 2022 02:28:26 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 43A44E037F
	for <cocci@sympa.inria.fr>; Tue,  1 Mar 2022 02:28:23 +0100 (CET)
Authentication-Results: mail2-smtp-roc.national.inria.fr; spf=None smtp.pra=cocci@lists.ewheeler.net; spf=None smtp.mailfrom=cocci@lists.ewheeler.net; spf=None smtp.helo=postmaster@mx.ewheeler.net
IronPort-SDR: 9biT8sNxRu89J8ZnTEYxnpNjF7UzDyJIffDi2eIa8ZYgCblroYLAjXg31hhvu1EMIqf0OvHmXx
 CysTKSLthdpdLsuajLEDpf4yA3U6dqQR03Yvmlhnt7PxW39wDCQhqVvmU6HdNtdzhmJ/bhM7MD
 rruVwElI9lz8BuW92dKnGyJIVgqd57hsVAvQcGskf1A3vh9K3+Sr/a7pX/8slyBoFs8To1ErOm
 OnWneQgn5mil/o+t2EYzIDsogdKEZ/nMTOYkK/u1Xc3zdHze4r0tzqta4eyJobP9JKKcekygua
 SiEMhJNxKqUBnvd3aqR1w8H4
X-IPAS-Result: =?us-ascii?q?A0BSBADOdR1i/0Xcza1agQmBWoIoB3dWAQEBKQQLRJU9L?=
 =?us-ascii?q?gOcW4F8CwEDAQ0tFAQBAYUHAoQRAh0GBjIHDgECBAEBAQEDAgMBAQEBAQEDA?=
 =?us-ascii?q?QEFAQEBAgEBAgMEAYEILAFjAWcBgU4BgXkGBDANgjUpAYNkAQUnEw8wEAsYL?=
 =?us-ascii?q?lcGgxcBgxauWoEBMoEBiXuBPIYSE0KHXSccQIFNgRUnDIJHMD6KQgSVSIEPg?=
 =?us-ascii?q?SdKWlifdoITnhGDUp9TBhQulkORYpZSoT2FOIE/KQYvgVkfFBoIJgqDJAlFA?=
 =?us-ascii?q?QIBAgEMAQICAQIBAgECAQgBAQIBjigWiGSFayABAQExOAIGCwEBAwmTDQEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:JD7lsq2CoDKYp1izYfbD5et3kn2cJEfYwER7XKvMYLTBsI5bpz0Dz
 zcWXGnQO/vYMDOmc9wkaInl9E9XvZaGydUxSQQ+3Hw8FHgiRejtVY3IdB+oV8+xBpSeFxw/t
 512hv3odp1coqr0/0/1WlTZhSAgk/nOH9IQMcacUsxLbVYMpBwJ1FQyw4bVvqYy2YLjW1nX6
 YuoyyHiEAbNNwBcYjp8B52r80sHUMTa4Fv0aXRjDRzjlAa2e0g9VPrzF4npR5fLatU88tqBe
 gr25OrRElU1UPsaIojNfr7TKiXmS1NJVOSEoiI+t6OK2nCuqsGuu0o2HKJ0VKtZt9mGt+4p6
 dNs7I3rc0QsFPzqlv0kbTZ9Tz4raMWq+JefSZS+mcmDiUDZc3bhx/h0Skc7IeX0+M4uXjoIr
 6RFbmpXNlbd1opaw5rjIgVors8kJ8LqFIceoW17izzGDfsrRZ3ZBaPH+be02R9q3Z4fRqaAP
 aL1bxJPT0T9Owd1GW0PFYhjkdmFoEjubDJh/Qf9Sa0fuDSNl10ugNABKuH9cduBTsR9hVedv
 muA/mLjAxhcOsb34T6M7XuogsfdnCbxQotUFbui9/csjkf7+4AIIBgGE1akofS0jkOkHdRSN
 yT45xbCs4AMrG2tb4DsBCf7pVTVmBAFYuR/NrElvVTlJrXv3y6VAW0NTzhkYdMgtdMrSTFC6
 mJlj+8FFhQ07+LIESP1GqO86GLtaXJMfAfucAddFVNdi+QPtr3fmf4mczqOOKulyNDqGTz9x
 z2Q6i4zm93/bPLnNY3gojgrYBr2+vAlqzLZAC2NBgpJCSskDLNJn6TytTDmAQ9ode50jjCp5
 RDoYfS24uEUFo2qnyeQWugLF7zBz6/bbGOE3gU1RcB+qmzFF5ufkWZ4u20WyKBBaZlsRNMUS
 BWO52u9GrcMVJdVUUOHS9ntVZ97kviI+SXNW+/UY9dKb4JwcgTCpHgGWKJj9zuFraXt+IlhU
 aqmnTGEVi5LWfw6l2PtH4/wE9YDn0gD+I8afrijpzzP7FZUTCf9pW4tPATcY+YnwrmDpQmJo
 d9TO9HTm0dbUfbieW/a7o4eIFQHNz49CIyv855bceuKIwxHHmA9CqaLneh7I9E8w/1YxrXS4
 3Wwek5E016h13fJHgW9dSwxYr3YW5si/2kwOjYhPAv21iF7M5qv9qoWa7A+YaIjqL541fdxQ
 vRcI5eAD/1DRy7p4TMYaZWh/oVueA7y1VCKPjG5e34yYJ5tSgjE4Jnicxe2rHsCCS++tM0fp
 by811qBHcFZH1k7UJ/bMav9wUmwsH4RnPNJc3HJetQDKl/x9IVKKjDqiqFlKc87KSLcmmmQ2
 TGQDEpKvuLKuYI0rYfE3PjWs4ezHuJiNUNGBG2Hv62uPCzX82f/k49NVOGEIWLUWG/uofjwY
 PUTwu78PfADkUwMtYdgSu45waU77trphrlb0gU9RimQNQz2U+85LynUx9RLu41M2qRd51m8V
 HWPzcYGa7+HD8XoTQwKLw0/Y+Xei/xNwmvO7e44KVnR7TNs+ObVSl1bOhSB1H5HIL1uPN93y
 OstopdLuQmvzBc1MtuLii1OsWKBMiVYAakgs5gbBq7tixYqkwseOsaEV3aquZzfOc9RNkQKI
 yOPgPSQjbprxn3dLyg5G0/L0LcPnp8Joh1LkQEPfgzbhtrfi/Yr9xRN6jBrHB9NxxBK3u8b1
 rKH7KGpyXFiPguEhfSvm0ipC0dMGx2U90j80R0PmXGxo4xEkIDSBDVVBApP1BlxH6Fgkvxz+
 LCD1H2jXCnqccz10zF0X0N5wxAmoRqd6SWa8P1K3K25810SZTv+nrToaHUIphbjDNl3gkDbz
 QWvECCcdoWjXRMtT2YH50V2GFjepN1o5ICPfB25wJ40IA==
IronPort-HdrOrdr: A9a23:XISuqKnOeTG9DD3Ta/NJd2MyBBHpDfIo3DAbv31ZSRFFG/Fw9v
 re5cjyt3fP5wr5N0tPpTntAsi9qDbnhPtICOoqTNGftWvdyQ+VxehZhOOIrlHd8m/Fh4lgPM
 xbAspD4bPLbWSSUvyR3CCzGb8bsbq6zJw=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.90,144,1643670000"; 
   d="scan'208";a="23693862"
X-MGA-submission: =?us-ascii?q?MDHRRviK+W26zoPu5pyf8xFm9t631EmImXPKmI?=
 =?us-ascii?q?2kGhaEF7v6xPXVNqL9P20moL6XxEqUTCKVINJ+2VhDg/m2BUE/WIZqMi?=
 =?us-ascii?q?jyeJdqFYqQ+E1DdOK4XY87eEZYKGhKhLlvlTFYFjSrZ71Ajol5E+ux/T?=
 =?us-ascii?q?gE7a/9vs9o1WseOKyYBw6K8A=3D=3D?=
Received: from mx.ewheeler.net ([173.205.220.69])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2022 02:28:21 +0100
Received: from localhost (localhost [127.0.0.1])
	by mx.ewheeler.net (Postfix) with ESMTP id D0AC44A;
	Mon, 28 Feb 2022 17:28:19 -0800 (PST)
X-Virus-Scanned: amavisd-new at ewheeler.net
Received: from mx.ewheeler.net ([127.0.0.1])
	by localhost (mx.ewheeler.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 9J5YvHo2KsE0; Mon, 28 Feb 2022 17:28:15 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx.ewheeler.net (Postfix) with ESMTPSA id 6AF6B39;
	Mon, 28 Feb 2022 17:28:15 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx.ewheeler.net 6AF6B39
Date: Mon, 28 Feb 2022 17:28:13 -0800 (PST)
From: Eric Wheeler <cocci@lists.ewheeler.net>
To: Julia Lawall <julia.lawall@inria.fr>
cc: cocci@inria.fr
In-Reply-To: <alpine.DEB.2.22.394.2202280705080.3112@hadrien>
Message-ID: <9b8e4283-90ff-2299-2a5e-ca12e65fe3fc@ewheeler.net>
References: <b6b8a7b6-1472-a6f0-1336-95d53ee82bd@ewheeler.net> <alpine.DEB.2.22.394.2202280705080.3112@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Can you match identifiers of a specific type?
Reply-To: Eric Wheeler <cocci@lists.ewheeler.net>
X-Loop: cocci@inria.fr
X-Sequence: 157
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-03/9b8e4283-90ff-2299-2a5e-ca12e65fe3fc%40ewheeler.net>

On Mon, 28 Feb 2022, Julia Lawall wrote:
> On Sun, 27 Feb 2022, Eric Wheeler wrote:
> 
> > Hello,
> >
> > Can I match only specific identifier types and names where the type is a
> > typedef? I've been reading as much as I can about Coccinelle but I've not
> > found a way to do it.
> >
> > I'm trying to move global calculation structures into its own typedef
> > structure to create a thread-safe environment where multiple threads can
> > work on different struct instances.  Right now the code works only on
> > static global values so parallelism is not possible without fork()ing.
> > (This is for the www.xnec2c.org project.)
> >
> > The code that looks pretty close to the following:
> >
> > 	// Globals
> > 	typedef struct {
> > 		int a;
> > 	} data_t
> >
> > 	data_t data;
> >
> > 	void f(char *data)
> > 	{
> > 		data[0] = 0; // parameter
> > 	}
> >
> > 	void g()
> > 	{
> > 		data.a = 0; // global
> > 	}
> >
> > I want to put all of the global 'data' variables of type 'data_t' into a
> > new structure as follows:
> >
> > 	typedef struct {
> > 		data_t data;
> > 		// and many others...
> > 	} nec_t;
> >
> > 	nec_t *nec;
> >
> > and replace the functions above as:
> >
> > 	void f(char *data)
> > 	{
> > 		data[0] = 0; // Does NOT change
> > 	}
> >
> > 	void g()
> > 	{
> > 		nec->data.a = 0; // This DOES change
> > 	}
> >
> > With a rule something like this:
> >
> > 	@ rule1 @
> > 	typedef data_t;
> > 	type T = {data_t};
> > 	identifier I = {data};
> 
> This means that your variable I should always be called "data".  Is that
> what you intended?
> 
> You should be able to do
> 
> idexpression data_t I = {data};
> 
> Then you want to use the name in a structure field.  Te problem is that a
> structure field is not an expression, it is an identifier.  So you have to
> make the match in two ways:
> 
> @@
> idexpression data_t I = {data};
> identifier j;
> @@
> 
> -I@j
> +nec->j

Thanks Julia, that seems to work (I added `typedef data_t;` to the .cocci 
file).

What does I@j mean?  Can you point me at documentation?

-Eric
