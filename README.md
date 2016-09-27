# EEG REST

An implementation of:

> Yao, Dezhong. 2001. “A Method to Standardize a Reference of Scalp EEG Recordings to a Point at Infinity.” Physiological Measurement 22 (4): 693. doi:10.1088/0967-3334/22/4/305.

We use Yao's original program (`LeadField.exe`) for generating the matrix G from the paper, and then new original code to do the rest of the calculations.

All original software is MIT licensed, but the copy of `LeadField.exe` was released onto the internet without a clear license. Please see the [author's website](http://www.neuro.uestc.edu.cn/rest/) for more details and the most up to date copy of this program. (Our copy is the 2015 version.)
