From: elezegarcia@gmail.com (Ezequiel Garcia)
Date: Wed, 26 Sep 2012 12:40:45 -0300
Subject: [Cocci] Help with SMPL
In-Reply-To: <50631EE2.4030208@metafoo.de>
References: <CA+MoWDrEmG1NowmRpB3S_4MnnxOk1q9=fo-tkCmL3PLrgn5K0w@mail.gmail.com>
 <50631EE2.4030208@metafoo.de>
Message-ID: <CALF0-+WC8EG861-szF3yQQEpawvv8QS4j7qZTqZGKy08-8=Ekg@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi,

On Wed, Sep 26, 2012 at 12:27 PM, Lars-Peter Clausen <lars@metafoo.de> wrote:
> On 09/26/2012 04:36 PM, Peter Senna Tschudin wrote:
>> Dear List,
>>
>> I'm trying to make a semantic patch for the case described on the patch:
>> http://www.mail-archive.com/linux-media at vger.kernel.org/msg52660.html
>>

More cases like these:

http://patchwork.linuxtv.org/patch/13100/

This is part of a whole patchset with subject:

media: XXX: Replace struct memcpy with struct assignment

The type of src and dst structs should match, but in some buggy code
that may not be true.

Hope it helps,
Ezequiel.
