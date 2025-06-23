# ------
# Before
# ------

# total1 = total2 = total3 = 0

# for i in range(0, 100000000):
#   total1 += i
# print(total1)

# for i in range(100000001, 200000000):
#   total2 += i
# print(total2)

# for i in range(200000001, 300000000):
#   total3 += i
# print(total3)

# print(">>>>> END <<<<<<<")


from multiprocessing import Process


def start_get(start, end):
  total = 0
  for i in range(start, end):
    total += i
  print(total)

if __name__=='__main__':
  # Process 만들기
  p0 = Process(target=start_get, args=(0,10000000))
  p1 = Process(target=start_get, args=(10000001,20000000))
  p2 = Process(target=start_get, args=(20000001,30000000))

  # Process 시작
  p0.start()
  p1.start()
  p2.start()

  # 프로세스 순서 정하기
  p0.join()
  p1.join()
  p2.join()

  print(">>>>> END <<<<<")