From: lars@metafoo.de (Lars-Peter Clausen)
Date: Wed, 26 Sep 2012 18:01:27 +0200
Subject: [Cocci] Help with SMPL
In-Reply-To: <CALF0-+WC8EG861-szF3yQQEpawvv8QS4j7qZTqZGKy08-8=Ekg@mail.gmail.com>
References: <CA+MoWDrEmG1NowmRpB3S_4MnnxOk1q9=fo-tkCmL3PLrgn5K0w@mail.gmail.com>
 <50631EE2.4030208@metafoo.de>
 <CALF0-+WC8EG861-szF3yQQEpawvv8QS4j7qZTqZGKy08-8=Ekg@mail.gmail.com>
Message-ID: <506326D7.4040802@metafoo.de>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On 09/26/2012 05:40 PM, Ezequiel Garcia wrote:
> Hi,
> 
> On Wed, Sep 26, 2012 at 12:27 PM, Lars-Peter Clausen <lars@metafoo.de> wrote:
>> On 09/26/2012 04:36 PM, Peter Senna Tschudin wrote:
>>> Dear List,
>>>
>>> I'm trying to make a semantic patch for the case described on the patch:
>>> http://www.mail-archive.com/linux-media at vger.kernel.org/msg52660.html
>>>
> 
> More cases like these:
> 
> http://patchwork.linuxtv.org/patch/13100/
> 
> This is part of a whole patchset with subject:
> 
> media: XXX: Replace struct memcpy with struct assignment
> 
> The type of src and dst structs should match, but in some buggy code
> that may not be true.

I suppose these should not be auto-converted since there is clearly a bug
somewhere. The following cocci patch can be used to find locations where
memcpy is used and the types of "to" and "from" do not match, but the size
parameter is sizeof one of them.

@r1@
type T;
T to;
T from;
position p;
@@
memcpy at p(&to, &from,
(
 sizeof(T)
|
 sizeof(to)
|
 sizeof(from)
)
 );

@r2@
type T;
T to;
const T from;
position p;
@@
memcpy at p(&to, &from,
(
 sizeof(T)
|
 sizeof(to)
|
 sizeof(from)
)
 );


@@
position p != {r1.p,r2.p};
type T1, T2;
T1 to;
T2 from;
@@
*memcpy at p(&to, &from,
(
 sizeof(T1)
|
 sizeof(T2)
|
 sizeof(to)
|
 sizeof(from)
)
*);
