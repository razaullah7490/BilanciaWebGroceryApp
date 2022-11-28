import 'package:grocery/Application/exports.dart';

class BarcodeScanner extends StatefulWidget {
  final void Function(String) getBarcode;
  const BarcodeScanner({
    super.key,
    required this.getBarcode,
  });

  @override
  State<BarcodeScanner> createState() => _BarcodeScannerState();
}

class _BarcodeScannerState extends State<BarcodeScanner> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  Barcode? result;
  bool isBarcode = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSize.p10,
          vertical: AppSize.p10,
        ).r,
        margin: const EdgeInsets.symmetric(
          horizontal: AppSize.p22,
          vertical: AppSize.p18,
        ).r,
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(10).r,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            switchCamera(
              image: Assets.switchCameraImage,
              onTap: () async {
                await controller?.flipCamera();
                setState(() {});
              },
            ),
            GestureDetector(
              onTap: () async {
                await controller?.toggleFlash();
                setState(() {});
              },
              behavior: HitTestBehavior.opaque,
              child: FutureBuilder(
                  future: controller?.getFlashStatus(),
                  builder: (context, snapshot) {
                    if (snapshot.data == true) {
                      return Image.asset(
                        Assets.flashOnImage,
                        width: 25.w,
                        height: 25.w,
                        color: AppColors.whiteColor,
                      );
                    } else {
                      return Image.asset(
                        Assets.flashOffImage,
                        width: 25.w,
                        height: 25.w,
                        color: AppColors.whiteColor,
                      );
                    }
                  }),
            ),
            backButton(
              image: Assets.cancelCameraImage,
              onTap: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
              cameraFacing: CameraFacing.back,
              overlay: QrScannerOverlayShape(
                borderColor: AppColors.primaryColor,
                borderWidth: 15.w,
                borderRadius: 15.r,
                cutOutHeight: 150.h,
                cutOutWidth: 300.w,
                borderLength: 15.r,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget switchCamera({required String image, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Image.asset(
        image,
        width: 25.w,
        height: 25.w,
        color: AppColors.whiteColor,
      ),
    );
  }

  Widget backButton({required String image, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.only(
          bottom: AppSize.p6,
        ).r,
        child: Image.asset(
          image,
          width: 25.w,
          height: 25.w,
          color: AppColors.whiteColor,
        ),
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        if (scanData.code != null) {
          if (isBarcode) {
            widget.getBarcode(scanData.code.toString());
            Navigator.pop(context);
            isBarcode = false;
          } else {}
        }
      });
    });

    controller.pauseCamera();
    controller.resumeCamera();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
