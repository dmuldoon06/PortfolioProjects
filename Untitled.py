#!/usr/bin/env python
# coding: utf-8

# In[1]:


import numpy as np 


# In[2]:


# telling numpy to not use scientific notation and displaying only 2 digits after decimal for numbers
np.set_printoptions(suppress = True, precision = 2)


# In[3]:


# imported data also have # in dataset so had to changes comments = | b/c had issue with import.
lab_test_rawdata = np.genfromtxt("Lab-test-import-edit1.csv",
                              delimiter = ',',
                              comments="|", 
                              skip_header = 1)
lab_test_rawdata


# In[5]:


#checking to see how many NAN values we have 
np.isnan(lab_test_rawdata).sum()


# In[6]:


#running this to see which cols contain all string values and which ones contain int.
temp_mean = np.nanmean(lab_test_rawdata, axis = 0)
temp_mean 


# In[7]:


#want to split data into strings cols and numeric cols 
#if col contains strings, mean will return nan and if .isnan 
#the argwhere tests if values are different from 0 since true (.isnan) is different from 0, this will return all the index values of the columns that contain strings. 

col_str = np.argwhere(np.isnan(temp_mean)).squeeze()
col_str


# In[8]:


#want to do the same thing for columns with numeric data for further analysis
col_numeric = np.argwhere(np.isnan(temp_mean)== False).squeeze()
col_numeric


# In[9]:


#then we need to re-import the data in two separate data sets
#used filling_val = 0 b/c with this particular dataset i know that if we have a missing value we didnt test sample so it should be represented as 0
lab_test_data_numeric = np.genfromtxt("Lab-test-import-edit1.csv", 
                                      delimiter = ',', 
                                      skip_header = 1, 
                                      autostrip = True, 
                                      usecols = col_numeric, 
                                      filling_values = 0, 
                                      comments= "|")
lab_test_data_numeric


# In[10]:


lab_test_data_str = np.genfromtxt("Lab-test-import-edit1.csv", 
                                      delimiter = ',', 
                                      skip_header = 1, 
                                      autostrip = True, 
                                      usecols = col_str, 
                                      comments= "|",
                                      dtype = np.str)
lab_test_data_str


# In[11]:


#now need to import the headers so we don't lose track of what data is what
#skip_footer line ignores all rows after the header since we skipped header in import. 
full_header = np.genfromtxt("Lab-test-import-edit1.csv", 
                           delimiter = ',', 
                           skip_footer = lab_test_rawdata.shape[0],
                           autostrip = True, 
                           dtype = np.str)
full_header


# In[12]:


#now we need to separate out the headers
str_header, numeric_header = full_header[col_str], full_header[col_numeric]
numeric_header
str_header


# In[13]:


#now that we have separated the data, good time to set up a checkpoint so we don't lose work so far
def checkpoint(file_name, checkpoint_header, checkpoint_data):
            np.savez(file_name, header = checkpoint_header, data = checkpoint_data)
            checkpoint_variable = np.load(file_name + ".npz")
            return(checkpoint_variable)


# In[14]:


#assigning a new variable to the checkpoint function we just defined 
checkpoint_str = checkpoint("checkpoint-str", str_header, lab_test_data_str)
checkpoint_str['data']
checkpoint_str['header']


# In[15]:


checkpoint_numeric = checkpoint("checkpoint-numeric", numeric_header, lab_test_data_numeric)
checkpoint_numeric['data']
checkpoint_numeric['header']


# In[ ]:




