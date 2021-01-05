import os
import time
import cv2

OUT_DIR = '2020-10-27'

"""实现IPcamera的实时显示,并且实现数据采集和视频存档
    """


if __name__ == '__main__':

    # !获取视频流读入接口
    cv2.namedWindow("camera", 1)
    # *开启ip摄像头
    # video = "http://admin:admin@192.168.1.118:8081/"  # *此处@后的ipv4 地址需要修改为自己的地址
    # capture = cv2.VideoCapture(video)
    # *电脑本机摄像头
    capture = cv2.VideoCapture(1)
    # 获取视频流打开状态
    if capture.isOpened():
        rval, frame = capture.read()
        print('ture')
        now_time = time.strftime('%Y-%m-%d-%I-%M-%S')
        # out_dir = os.path.join(os.getcwd(), now_time)
        out_dir = OUT_DIR
        if not os.path.exists(out_dir):
            os.makedirs(out_dir)
    else:
        rval = False
        print('False')
        exit(-1)

    # !设置视频文件的格式
    # fps = capture.get(cv2.CAP_PROP_FPS)
    # print(fps)
    # # *获取cap视频流的每帧大小
    # size = (int(capture.get(cv2.CAP_PROP_FRAME_WIDTH)),
    #         int(capture.get(cv2.CAP_PROP_FRAME_HEIGHT)))
    # print(size)
    # # *定义编码格式mpge-4
    # fourcc = cv2.VideoWriter_fourcc('M', 'P', '4', '2')
    # # *定义视频文件输入对象
    # outvideo = cv2.VideoWriter(os.path.join(
    #     out_dir, now_time+'.avi'), fourcc, fps, size)

    # !循环显示视频帧
    img_list = os.listdir(out_dir)
    num = 0
    if len(img_list) != 0:
        num = int(img_list[-1].split('.')[0])
    str_length = 6
    ratio = 0.3
    while rval:
        success, img = capture.read()
        frame = cv2.resize(
            img, dsize=None, fx=0.5, fy=0.5, interpolation=cv2.INTER_CUBIC)
        cv2.imshow("camera", frame)

        # 按键处理，注意，焦点应当在摄像头窗口，不是在终端命令行窗口
        key = cv2.waitKey(10)

        if key == 27:
            # esc键退出
            print("esc break...")
            break
        if key == ord(' '):
            # 保存一张图像
            num = num + 1
            len_num = len(str(num))
            filename = '0'*(str_length-len_num) + str(num)+'.jpg'
            cv2.imwrite(os.path.join(out_dir, filename), img)
        # !保存视频文件
        # outvideo.write(img)
        # cv2.waitKey(1)
    capture.release()
    # outvideo.release()
    cv2.destroyWindow("camera")
