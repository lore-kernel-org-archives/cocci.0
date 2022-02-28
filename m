Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B35FEC433EF
	for <cocci@archiver.kernel.org>; Mon, 28 Feb 2022 04:25:08 +0000 (UTC)
X-IronPort-AV: E=Sophos;i="5.90,142,1643670000"; 
   d="scan'208";a="23470969"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 28 Feb 2022 05:25:06 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 5E9A7E037F; Mon, 28 Feb 2022 05:25:06 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 2F9E2E037F
	for <cocci@sympa.inria.fr>; Mon, 28 Feb 2022 05:25:05 +0100 (CET)
Authentication-Results: mail2-smtp-roc.national.inria.fr; spf=None smtp.pra=cocci@lists.ewheeler.net; spf=None smtp.mailfrom=cocci@lists.ewheeler.net; spf=None smtp.helo=postmaster@mx.ewheeler.net
IronPort-SDR: 8akF2AC1rCb2ynQp5xD83VbzvxjyE4x3w/tgQgwOlKlmHixjx+S/wsuPcDj83pM7EkS3I26hzG
 mB7dF+F1QeLyr+4rhwB0aWb/cFQGF/+8Hugl8U/Q5eddB81h0PWhd3CBtKp4fixuVTic24fn43
 AINz1iewSWh0VJgExq2wxhXnS1lgFrXkfljs9EBkTA8o4zipgblZtElBZDGkE8uVsBhzEZSO3P
 8zb/ZsVMRSXFtIyLTDMHH1SRZ4Dn6ktbPkxYJdzs7UjTlJ7ptyrhMzywjswJK1BvpAtKoxiJlr
 R8LUhKF1OqLz35tktCoyjBAo
X-IPAS-Result: =?us-ascii?q?A0CVCgBkTRxi/0Xcza1aHQEBPAEFBQECAQkBFYFaAoImB?=
 =?us-ascii?q?3dWAQEBKQQLRJNGgiWDKZsxCwEDAQ0SAhkUBAEBiRkCHQYGMwYOAQIEAQEBA?=
 =?us-ascii?q?QMCAwEBAQEBAQMBAQUBAQECAQECAwQBgQgsAWMBZwGBTgGBeQYEMA2CNSKEG?=
 =?us-ascii?q?RMPhQUBgxauSoEBMoEBiXuBPAGGERNCh10nHECBTYEVJwyCR4swBJUWEj4+H?=
 =?us-ascii?q?oEcgSRYkhWPdIsnkmqDUgWJZo8BhmcaLoQ6kgmRYpZSoT0WgT+DY4E/OCaBW?=
 =?us-ascii?q?R8UGggmCoMkCUUBAgECAQwBAgIBAgECAQIBCAEBAgGOKBaIZIVrIAEBATE4A?=
 =?us-ascii?q?gYLAQEDCZMNAQE?=
IronPort-PHdr: A9a23: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
 O6diSJ0M3Be249enRf1
IronPort-Data: A9a23:CJ8rkKOCF40ro17vrR2/kcFynXyQoLVcMsEvi/4bfWQNrUok1zBSz
 TBOW2CAOf2MZmryfY8gadjj/EpUucPUyIBrTnM5pCpnJ55ogZqcVI7Bdi8cHAvLc5adFBo/h
 yk6QoOdRCzhZiaE/n9BCpC48T8kk/jgqoPUUIYoAAgoLeNfYHpn2EoLd9IR2NYy24DjWVzV4
 7senuWGULOb824sWo4rw/nbwP9flKyaVOQw4zTSzdgS1LPvvyF94KA3fcldHFOkKmVgJdNWc
 s6YpF2PEsw1yD92Yj+tuu6TnkTn2dc+NyDW4pZdc/DKbhSvOkXe345jXMfwZ3u7hB2Cmdts8
 tcQiaeTagojOZbUwLUHSgtxRnQW0a1uoNcrIFC6oYqe0E3Lfn/h2bNoAV1e0Y8wo7ksRzsWq
 LpCcmhLMEHra+GemNpXTsFngc8oLeHvPZgDoTdt0jHUAPIrW9bFTrmiCdpwhmxs2ZgfQ6a2i
 8wxcyNoZQX6ahJ0awkmGbUD3/yIg2PjWmgNwL6SjfFrvTOCk1wZPKLWGNHScdeLbd5Em16R4
 GPA5WXwRB8AXOFz0hKA4jShme/CkCf2QsQUGaHQGuNWbEO7zWoYFScUCGeAgtq0gEmFQ4oOM
 VUG0397xUQtz3CDQt74Vhy+hXeLuB8ARtZde9EHBBGxJrn8uFnGWzBVJtJVQJl3659sHG1CO
 kqhxouxXVRSXKuppWVxH4p4QBu3KW4YMm8PaCsJV00D7sWLTGAPYvDnFYcL/E2d1IGd9dTML
 9ei8UADa00715Jj6klC1QmvbvLFjsGhovQJzgvWRHm5yQhyeZSoYYelgXCCs6odfdbHHwTc4
 Sda8yR70AzoJcvc/MBqaL5SdIxFGt7fbWO0baBHQfHNCAhBC1b4Id4LsW4uTKuYGssbeTLkZ
 ELJuAVaoccKVEZGnocsC79cyq0Ck8DdKDgSfquMP4oWP8MoL1fvEeMHTRf44l0BWXMEyckXU
 ap3u+71ZZrDIag4njewWckH1ronmnI3yW/JHMCpyxW8zaHYaWGVRLoBPUHIaO0ltfvWrALQ+
 tdZFs2L1xQGCrGlOHGKqNJKIABYN2U/CLD3t9dTKLyJLD1mL359WfXf9rUsJt5+lKNPm+aVo
 HzkAh1EyEDyjGHsIBmRbiwxc6vmWJty9CppPSElMVuy9WIkZIKjsPUWe5ctJOl18O140eUyQ
 uYFdsiED+4JTDnbomxPYZ74pY1kVRKqmQPXZXb+OmBiJsI5SlWQqNH+fwbp+C0fNQaNtJMz8
 ++6ywfWYZsfXAA8XszYX/KY0A/jt3Yqnu8vDVDDJcNeeRiy/dEyeTDxlPI+P+oFNQ7HmmmBz
 w+TDBoV+bvNrosy/IWbjKyItd70Qe5uWEdFH2TW6buscy/X4jP7k4NHVe+JexHbVX/1of/+P
 r8NkqigafBXzkxXt4dcEqpwyfxs7dXYp4hFklZuEkLNYgn5EbhnOHSHgJdC7/Uf2r9DtAKqc
 UuT4d0Ga66RMcboHQJDPgYjdejfh/gYliOLsKYwMAP3+y968b6KSwNUMgXV0H5RK758MYUEx
 +Y9uZdMt1fl0kdzbo+L3nJO6mCBDn0cSKF55JsUN4/clVZ5wF91Z5GBWDT954uCaogSPxByc
 COUnqfLm59V2lHGLygoDXHI0OdQ7XjUVMumELPWy5W1dtv5ajsf2Q0X/Cs3QwlRww8B1e9vU
 oSu24uZOo3WlwqERuAaN4xvJ+2FLBmY4VDqjVYWlGDUS0SyEGrAMAXR/ApLEF8xqwphk/syw
 F1c4GLkSirxOszu3iY/XUN/7fruUbSdM+EEdN+PR6y4InXxXdYpbmJCq4bFR9sLzP7dXHH6m
 NQ=
IronPort-HdrOrdr: A9a23:S64aMq2+CqDduQXZMDlOrQqjBKIkLtp133Aq2lEZdPU1SL39qy
 jN9M516faaslgssR0b+OxoW5PwJE80l6QFg7X5VI3KNGKK1FdAR7sSjrcKrQeBJ8QgzIRg6Z
 s=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.90,142,1643670000"; 
   d="scan'208";a="23470968"
X-MGA-submission: =?us-ascii?q?MDEG06kB0PbzxGEvmhk6izjzqXRj2g+mD088Hy?=
 =?us-ascii?q?IvUd1hQU49VZU6R9SFH2ZDEZzyVal/xkOxIzgExKK/l0n8mwTzWtSYKf?=
 =?us-ascii?q?yRob1aJwQbv/Zb+ZpUVmYZtQ8lG0BBXUyIjiJtaCWVTK3FDG+hvtUVds?=
 =?us-ascii?q?To5E2vA+Y8bI9ZT3RgEKL4tQ=3D=3D?=
Received: from mx.ewheeler.net ([173.205.220.69])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 05:25:03 +0100
Received: from localhost (localhost [127.0.0.1])
	by mx.ewheeler.net (Postfix) with ESMTP id 97A8D49
	for <cocci@inria.fr>; Sun, 27 Feb 2022 20:25:01 -0800 (PST)
X-Virus-Scanned: amavisd-new at ewheeler.net
Received: from mx.ewheeler.net ([127.0.0.1])
	by localhost (mx.ewheeler.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 9SM2M3J8jGrb for <cocci@inria.fr>;
	Sun, 27 Feb 2022 20:24:57 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx.ewheeler.net (Postfix) with ESMTPSA id 2245740
	for <cocci@inria.fr>; Sun, 27 Feb 2022 20:24:57 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx.ewheeler.net 2245740
Date: Sun, 27 Feb 2022 20:24:52 -0800 (PST)
From: Eric Wheeler <cocci@lists.ewheeler.net>
To: cocci@inria.fr
Message-ID: <b6b8a7b6-1472-a6f0-1336-95d53ee82bd@ewheeler.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: [cocci] Can you match identifiers of a specific type?
Reply-To: Eric Wheeler <cocci@lists.ewheeler.net>
X-Loop: cocci@inria.fr
X-Sequence: 155
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-02/b6b8a7b6-1472-a6f0-1336-95d53ee82bd%40ewheeler.net>

Hello,

Can I match only specific identifier types and names where the type is a 
typedef? I've been reading as much as I can about Coccinelle but I've not 
found a way to do it. 

I'm trying to move global calculation structures into its own typedef 
structure to create a thread-safe environment where multiple threads can 
work on different struct instances.  Right now the code works only on 
static global values so parallelism is not possible without fork()ing.  
(This is for the www.xnec2c.org project.)

The code that looks pretty close to the following:

	// Globals
	typedef struct {
		int a;
	} data_t

	data_t data;

	void f(char *data)
	{
		data[0] = 0; // parameter
	}

	void g()
	{
		data.a = 0; // global
	}

I want to put all of the global 'data' variables of type 'data_t' into a 
new structure as follows:

	typedef struct {
		data_t data;
		// and many others...
	} nec_t;

	nec_t *nec;

and replace the functions above as:

	void f(char *data)
	{
		data[0] = 0; // Does NOT change
	}

	void g()
	{
		nec->data.a = 0; // This DOES change
	}

With a rule something like this:

	@ rule1 @
	typedef data_t;
	type T = {data_t};
	identifier I = {data};
	@@
	-I
	+nec->I

But of course T isn't actually used in that cocci example, but I want to 
make sure that I is always of type T but I'm not sure how. I tried 
idexpression but either it is not intended for this purpose. This gives a 
cocci syntax error, so clearly I do not have it correct, but maybe it 
explains what I'm trying to do:

	@ rule1 @
	typedef data_t;
	type T = {data_t};
	idexpression T I = {data};
	@@
	-I
	+nec->I

The whole struct I'm trying to refactor is below, you'll notice there are 
lots of different typedefs that are all being moved into the nec_t 
structure, but hopefully the description above explains what I'm trying to 
do.  The global variable names like "data" are always named the same, 
hence "identifier I={data}".  I just want to make sure that the 
replacement enforces the following:
   1. "data" is a global variable and it is named "data"
   2. "data" is of type "data_t"

The xnec2c code I am refactoring is very sensitive to the difference 
between a "complex double" and a "double" since complex numbers and real 
numbers can be multipled in C without error or compiler warnings.  

There are type collisions between local and global variables (I know, bad 
form, but thats how it is) so I need to make sure only the same data types 
are replaced even if the names collide between local/global identififers.

If the wrong local variable of type "double" was replaced with a global 
variable of type "complex double" or vice-versa, then the calculations 
would be wrong and it would be very difficult (or impossible) to figure 
out why.

Most of the identifiers like "near_field" are pretty unique and could be a 
simple search-replace with nec->near_field, but others like "data", "cm", 
and "cmag" might be used with different types so I hope Coccinelle can 
enforce replacement of the variable type.

Thanks for your help!

-Eric

More detail if you're curious:

The actual new nec_t structure looks like this; all of these fields are new and the code needs to replace
all occurances of each field with nec->field:

	typedef struct
	{
		// rad_pattern_t *rad_pattern; // pointer to the index into rad_pattern[freq_step]

		// Near E/H field data
		near_field_t near_field;

		complex double *cm;

		// Needed data
		impedance_data_t impedance_data;

		// Data for various calculations
		calc_data_t calc_data;

		// Magnitude of seg/patch current/charge
		double *cmag, *ct1m, *ct2m;

		crnt_t crnt;

		dataj_t dataj;

		data_t data;

		fpat_t fpat;

		ggrid_t ggrid;

		gnd_t gnd;

		gwav_t gwav;

		incom_t incom;

		matpar_t matpar;

		netcx_t netcx;

		save_t save;

		segj_t segj;

		smat_t smat;

		vsorc_t vsorc;

		zload_t zload;
	} nec_t;

