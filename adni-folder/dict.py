import csv
import re

print("ok so basically this program lets you see the most recent diagnosis")
filename=input("whats the file name \n")

all_results=[]
#result=dict(RID="RID",VISCODE2="VISCODE2",DIAGNOSIS="DIAGNOSIS")
#all_results=[result]
with open(filename,'r') as data:
    for line in csv.DictReader(data):
        key=int(line.pop('RID'))
        visit=line.pop('VISCODE2')
        visit=re.sub('\"','',visit)
        DIAGNOSIS=line.pop('DIAGNOSIS')
        if visit == 'sc' or visit == 'bl' or visit == '':
            visit = int(0)
        else:
            visit=int(re.sub('m','',visit))
        
        result={"RID":key,"VISCODE2":visit,"DIAGNOSIS":DIAGNOSIS}    
        n=0
        for idx, item in enumerate(all_results):
#                print(idx, item, key)
                if key==item["RID"]:
                    n=1
                    oldvisit=item["VISCODE2"]
                    if oldvisit < visit:
                        all_results[idx]=result
                    else:
                        pass
                    break
                else:
                    pass
        if (n==0):
            all_results.append(result)

all_results=sorted(all_results,key=lambda x: x['RID'])

print("\n ok so now it came out with your thing")
outputfilename=input("what do u want to name the output file \n")
fieldnames=all_results[0].keys()

with open(outputfilename,'w',newline='\n') as convert_file:
    writer=csv.DictWriter(convert_file, fieldnames=fieldnames)
    writer.writeheader()
    writer.writerows(all_results)
# =============================================================================
