import numpy as np

'''
np.array(
    [[0, 0, 0], [90, 0, 0], [505, 0, 0], [995, 0, 0], [1410, 0, 0], [1500, 0, 0],
     [505, 175, 0], [505, 385, 0], [505, 470, 0], [505, 580, 0],
     [995, 175, 0], [995, 385, 0], [995, 470, 0], [995, 580, 0],
     [0, 1400, 0], [1500, 1400, 0]], np.float32)

np.array(
    [[[, ]], [[, ]], [[, ]], [[, ]], [[, ]], [[, ]],
     [[, ]], [[, ]], [[, ]], [[, ]],
     [[, ]], [[, ]], [[, ]], [[, ]], 
     [[, ]], [[, ]]], np.float32)
'''

matrix_save = 'D:/Code/MultiCamOverlap/dataset/calibration/0425_44/information/'
cam_num = 4


objp_cam1 = np.array(
    [[0, 0, 0], [90, 0, 0], [505, 0, 0], [995, 0, 0], [1410, 0, 0], [1500, 0, 0],
     [505, 175, 0], [505, 385, 0], [505, 470, 0], [505, 580, 0],
     [995, 175, 0], [995, 385, 0], [995, 470, 0], [995, 580, 0]], np.float32)

corners_cam1 = np.array(
    [[[321, 618]], [[396, 617]], [[733, 613]], [[1182, 603]], [[1523, 591]], [[1591, 591]], 
[[697, 646]], [[651, 685]], [[624, 710]], [[603, 733]], 
[[1213, 625]], [[1266, 666]], [[1295, 687]], [[1325, 713]]], np.float32)

objp_cam2 = np.array(
    [[0, 0, 0], [90, 0, 0], [505, 0, 0], [995, 0, 0], [1410, 0, 0], [1500, 0, 0],
     [505, 175, 0], [505, 385, 0], [505, 470, 0], [505, 580, 0],
     [995, 175, 0], [995, 385, 0], [995, 470, 0], [995, 580, 0]], np.float32)

corners_cam2 = np.array(
    [[[803, 380]], [[850, 388]], [[1072, 423]], [[1410, 475]], [[1745, 537]], [[1817, 556]], 
[[976, 430]], [[842, 440]], [[782, 447]], [[727, 450]], 
[[1345, 486]], [[1245, 508]], [[1196, 521]], [[1136, 537]]], np.float32)

objp_cam3 = np.array(
    [[0, 0, 0], [90, 0, 0], [505, 0, 0], [995, 0, 0], [1410, 0, 0], [1500, 0, 0],
     [505, 175, 0], [505, 385, 0], [505, 470, 0], [505, 580, 0],
     [995, 175, 0], [995, 385, 0], [995, 470, 0], [995, 580, 0]], np.float32)

corners_cam3 = np.array(
    [[[794, 437]], [[822, 444]], [[983, 490]], [[1292, 575]], [[1751, 711]], [[1873, 750]], 
[[820, 500]], [[591, 517]], [[512, 525]], [[423, 535]], 
[[1102, 602]], [[807, 641]], [[664, 661]], [[506, 677]]], np.float32)

objp_cam4 = np.array(
    [[0, 0, 0], [90, 0, 0], [505, 0, 0], [995, 0, 0], [1410, 0, 0], [1500, 0, 0],
     [505, 175, 0], [505, 385, 0], [505, 470, 0], [505, 580, 0],
     [995, 175, 0], [995, 385, 0], [995, 470, 0], [995, 580, 0],
     [0, 1400, 0], [1500, 1400, 0]], np.float32)

corners_cam4 = np.array(
    [[[1625, 625]], [[1598, 637]], [[1507, 681]], [[1267, 783]], [[756, 967]], [[558, 1026]], 
[[1348, 661]], [[1160, 636]], [[1097, 624]], [[1044, 616]], 
[[1055, 740]], [[854, 696]], [[770, 681]], [[713, 656]], 
[[894, 540]], [[74, 590]]], np.float32)


save_objp = [objp_cam1, objp_cam2, objp_cam3, objp_cam4]
save_corners = [corners_cam1, corners_cam2, corners_cam3, corners_cam4]

np.save(matrix_save + 'objp.npy', save_objp)
np.save(matrix_save + 'corners.npy', save_corners)